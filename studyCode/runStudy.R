
# Check codeToRun inputs ----
validateCdmArgument(cdm,
                                  requiredTables = c("person",
                                                     "observation_period",
                                                     "condition_occurrence",
                                                     "drug_exposure",
                                                     "death",
                                                     "concept"))
assertNumeric(
  min_cell_count,
  integerish = TRUE,
  min = 0,
  length = 1
)

# Create a log file ----
createLogFile(logFile = tempfile(pattern = "log_{date}_{time}"))
logMessage("LOG CREATED")

# Initialise list to store results as we go -----
results <- list()

# CDM modifications -----
# CDM summary -----
results[["snapshot"]] <- summariseOmopSnapshot(cdm)
results[["observation_period"]] <- summariseObservationPeriod(cdm$observation_period)

# Instantiate study cohorts ----
logMessage("Instantiating study cohorts")
source(here("cohorts", "instantiateCohorts.R"))
logMessage("Study cohorts instantiated")

# Cohort counts and attrition ----
results[["cohort_count"]] <- summariseCohortCount(
  cdm$mi_events
)
results[["cohort_attrition"]] <-
  summariseCohortAttrition(cdm$mi_events)

# Run analyses ----
logMessage("Run study analyses")
source(here("analyses", "cohortCharacteristics.R"))
source(here("analyses", "cohortSurvival.R"))
logMessage("Analyses finished")

# Capture log file ----
results[["log"]] <- summariseLogFile(
  cdmName = cdmName(cdm)
)

# Finish ----
results <- results |>
  list_drop_empty() |>
  bind()
dir.create(here("Results"), recursive = TRUE, showWarnings = FALSE)
exportSummarisedResult(
  results,
  minCellCount = min_cell_count,
  fileName = "post_mi_beta_blocker_results_{cdm_name}_{date}.csv",
  path = here("Results")
)

cli_alert_success("Study finished")
