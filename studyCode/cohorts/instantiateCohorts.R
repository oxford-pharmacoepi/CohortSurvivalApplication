# Load and validate the supplied concept sets ----
source(here("codelist", "codelistCreation.R"))

# MI target events ----
cdm$mi_events <- CohortConstructor::conceptCohort(
  cdm = cdm,
  conceptSet = mi_concept_set,
  name = "mi_events",
  table = "condition_occurrence",
  exit = "event_start_date"
)

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
