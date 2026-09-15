
# Check codeToRun inputs ----
omopgenerics::validateCdmArgument(cdm,
                                  requiredTables = c("person",
                                                     "observation_period",
                                                     "condition_occurrence",
                                                     "drug_exposure",
                                                     "death",
                                                     "concept"))
omopgenerics::assertNumeric(
  min_cell_count,
  integerish = TRUE,
  min = 0,
  length = 1
)

# Create a log file ----
omopgenerics::createLogFile(logFile = tempfile(pattern = "log_{date}_{time}"))
omopgenerics::logMessage("LOG CREATED")

# Initialise list to store results as we go -----
results <- list()

# CDM modifications -----
# CDM summary -----
results[["snapshot"]] <- summariseOmopSnapshot(cdm)
results[["obs_period"]] <- summariseObservationPeriod(cdm$observation_period)

# Instantiate study cohorts ----
omopgenerics::logMessage("Instantiating study cohorts")
source(here("cohorts", "instantiateCohorts.R"))
omopgenerics::logMessage("Study cohorts instantiated")

# Cohort counts and attrition ----
results[["cohort_count"]] <- CohortCharacteristics::summariseCohortCount(
  cdm$mi_events
)
results[["cohort_attrition"]] <-
  CohortCharacteristics::summariseCohortAttrition(cdm$mi_events)

# Run analyses ----
omopgenerics::logMessage("Run study analyses")
source(here("analyses", "cohortCharacteristics.R"))
source(here("analyses", "cohortSurvival.R"))
omopgenerics::logMessage("Analyses finished")

# Capture log file ----
results[["log"]] <- omopgenerics::summariseLogFile(
  cdmName = omopgenerics::cdmName(cdm)
)

# Finish ----
results <- results |>
  vctrs::list_drop_empty() |>
  omopgenerics::bind()
dir.create(here("Results"), recursive = TRUE, showWarnings = FALSE)
CohortSurvival::exportSummarisedResult(
  results,
  minCellCount = min_cell_count,
  fileName = "post_mi_beta_blocker_results_{cdm_name}_{date}.csv",
  path = here("Results")
)

cli::cli_alert_success("Study finished")
