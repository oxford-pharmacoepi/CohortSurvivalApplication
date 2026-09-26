# Load the supplied concept sets ----
mi_concept_set <- importCodelist(
  here("codelist", "mi_concepts.csv"),
  type = "csv"
)
beta_blocker_concept_set <- importCodelist(
  here("codelist", "beta_blockers.csv"),
  type = "csv"
)

# All MI events used to apply the target-cohort eligibility criteria ----
cdm$all_mi_events <- conceptCohort(
  cdm = cdm,
  conceptSet = mi_concept_set,
  name = "all_mi_events",
  table = "condition_occurrence",
  exit = "event_start_date"
)

# Eligible MI target events ----
cdm$mi_events <- copyCohorts(
  cohort = cdm$all_mi_events,
  name = "mi_events"
) |>
  requireAge(ageRange = c(18, Inf)) |>
  requireInDateRange(
    dateRange = as.Date(c("2012-01-01", NA))
  ) |>
  requirePriorObservation(
    minPriorObservation = 365
  ) |>
  requireCohortIntersect(
    targetCohortTable = "all_mi_events",
    window = c(-28, -1),
    intersections = 0,
    targetEndDate = NULL
  ) |>
  requireIsFirstEntry()

# Beta-blocker outcome events ----
cdm$beta_blocker_events <- conceptCohort(
  cdm = cdm,
  conceptSet = beta_blocker_concept_set,
  name = "beta_blocker_events",
  table = "drug_exposure",
  exit = "event_start_date"
)

# Death competing events ----
cdm$death_events <- deathCohort(
  cdm = cdm,
  name = "death_events",
  subsetCohort = "mi_events"
)
