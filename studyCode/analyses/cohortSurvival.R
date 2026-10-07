# Time from MI to a recorded beta-blocker exposure (single event) ----
results[["single_event_beta_blocker_after_mi"]] <-
  estimateSingleEventSurvival(
    cdm = cdm,
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
