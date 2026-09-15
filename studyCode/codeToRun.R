# renv::activate()
# renv::restore()

library(DBI)
library(here)
library(CDMConnector)
library(omopgenerics)
library(OmopSketch)
library(CohortConstructor)
library(PatientProfiles)
library(CohortCharacteristics)
library(CohortSurvival)

# Database details ----
db_name <- "..."

db <- DBI::dbConnect(
  ...
)

cdm_schema <- "..."
write_schema <- "..."
write_prefix <- "..."

# Minimum count permitted by local data governance
min_cell_count <- 5

# Create the CDM reference ----
cdm <- CDMConnector::cdmFromCon(
  con = db,
  cdmSchema = cdm_schema,
  writeSchema = write_schema,
  writePrefix = write_prefix,
  cdmName = db_name
)

# Run the study ----
source(here("runStudy.R"))

CDMConnector::cdmDisconnect(cdm)
