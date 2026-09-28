# shiny is prepared to work with this resultList:
resultList <- list(
  summarise_omop_snapshot = list(result_type = "summarise_omop_snapshot"),
  summarise_observation_period = list(result_type = "summarise_observation_period"),
  summarise_cohort_count = list(result_type = "summarise_cohort_count"),
  summarise_cohort_attrition = list(result_type = "summarise_cohort_attrition"),
  summarise_characteristics = list(result_type = "summarise_characteristics"),
  survival = list(result_type = c("survival_summary", "survival_estimates", "survival_events", "survival_attrition")),
  summarise_log_file = list(result_type = "summarise_log_file")
)

source(file.path(getwd(), "functions.R"))

# Use the most recent exported result. Keeping older exports in the app folders
# must not mix analyses from different study runs.
resultFiles <- list.files(
  c(file.path(getwd(), "rawData"), file.path(getwd(), "data")),
  pattern = "[.]csv$",
  full.names = TRUE
)
if (length(resultFiles) == 0) {
  cli::cli_abort("No summarised-result CSV was found in {.path rawData/} or {.path data/}.")
}
resultDates <- sub(
  ".*_([0-9]{4}_[0-9]{2}_[0-9]{2})[.]csv$",
  "\\1",
  basename(resultFiles)
)
resultFile <- resultFiles[order(resultDates, file.info(resultFiles)$mtime, decreasing = TRUE)][1]

result <- omopgenerics::importSummarisedResult(resultFile)
data <- prepareResult(result, resultList)
values <- getValues(result, resultList)

# edit choices and values of interest
choices <- values
selected <- getSelected(values)

save(data, choices, selected, values, file = file.path(getwd(), "data", "studyData.RData"))

rm(result, values, choices, selected, resultList, data, resultDates, resultFile, resultFiles)
