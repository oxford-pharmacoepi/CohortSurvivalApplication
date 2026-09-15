# Time from MI to a recorded beta-blocker exposure ----
results[["beta_blocker_after_mi_survival"]] <-
  CohortSurvival::estimateSingleEventSurvival(
    cdm = cdm,
    targetCohortTable = "mi_events",
    outcomeCohortTable = "beta_blocker_events",
    outcomeWashout = 0,
    censorOnCohortExit = FALSE
  )

# Beta-blocker initiation after MI, with death as a competing event ----
results[["beta_blocker_after_mi_competing_risk"]] <-
  CohortSurvival::estimateCompetingRiskSurvival(
    cdm = cdm,
    targetCohortTable = "mi_events",
    outcomeCohortTable = "beta_blocker_events",
    competingOutcomeCohortTable = "death_events",
    outcomeWashout = 0,
    censorOnCohortExit = FALSE
  )
