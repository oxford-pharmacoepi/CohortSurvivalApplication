# Time from MI to a recorded beta-blocker exposure (single event) ----
# In CPRD Aurum, observation can extend beyond the estimated death date.
# Cap it at death for this analysis only so follow-up cannot continue after death.
single_event_cdm <- cdm
single_event_cdm$observation_period <-
  cdm$observation_period |>
  dplyr::left_join(
    cdm$death |>
      dplyr::select("person_id", "death_date"),
    by = "person_id"
  ) |>
  dplyr::mutate(
    observation_period_end_date = dplyr::if_else(
      !is.na(.data$death_date) &
        .data$death_date < .data$observation_period_end_date,
      .data$death_date,
      .data$observation_period_end_date
    )
  ) |>
  dplyr::select(-"death_date")

results[["single_event_beta_blocker_after_mi"]] <-
  estimateSingleEventSurvival(
    cdm = single_event_cdm,
    targetCohortTable = "mi_events",
    outcomeCohortTable = "beta_blocker_events",
    # The 365-day beta-blocker washout is applied when mi_events is created.
    outcomeWashout = 0,
    followUpDays = 365,
    censorOnCohortExit = FALSE
  )

# Beta-blocker exposure after MI, with death as a competing event ----
results[["competing_risk_beta_blocker_after_mi"]] <-
  estimateCompetingRiskSurvival(
    cdm = cdm,
    targetCohortTable = "mi_events",
    outcomeCohortTable = "beta_blocker_events",
    competingOutcomeCohortTable = "death_events",
    # Match the single-event estimand and follow-up window above.
    outcomeWashout = 0,
    followUpDays = 365,
    censorOnCohortExit = FALSE
  )
