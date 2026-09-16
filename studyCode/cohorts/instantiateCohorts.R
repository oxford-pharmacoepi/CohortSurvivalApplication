# Load and validate the supplied concept sets ----
source(here("codelist", "codelistCreation.R"))

# All MI events used to apply the target-cohort eligibility criteria ----
cdm$all_mi_events <- CohortConstructor::conceptCohort(
  cdm = cdm,
  conceptSet = mi_concept_set,
  name = "all_mi_events",
  table = "condition_occurrence",
  exit = "event_start_date"
)

# Eligible MI target events ----
cdm$mi_events <- CohortConstructor::copyCohorts(
  cohort = cdm$all_mi_events,
  name = "mi_events"
) |>
  CohortConstructor::requireAge(ageRange = c(18, Inf)) |>
  CohortConstructor::requireInDateRange(
    dateRange = as.Date(c("2012-01-01", NA))
  ) |>
  CohortConstructor::requirePriorObservation(
    minPriorObservation = 365
  ) |>
  CohortConstructor::requireCohortIntersect(
    targetCohortTable = "all_mi_events",
    window = c(-28, -1),
    intersections = 0,
    targetEndDate = NULL
  ) |>
  CohortConstructor::requireIsFirstEntry()

# Beta-blocker outcome events ----
cdm$beta_blocker_events <- CohortConstructor::conceptCohort(
  cdm = cdm,
  conceptSet = beta_blocker_concept_set,
  name = "beta_blocker_events",
  table = "drug_exposure",
  exit = "event_start_date"
)

# Death competing events ----
cdm$death_events <- CohortConstructor::deathCohort(
  cdm = cdm,
  name = "death_events",
  subsetCohort = "mi_events"
)
