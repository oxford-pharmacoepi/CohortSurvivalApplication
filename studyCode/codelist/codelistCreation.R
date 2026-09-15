read_concept_ids <- function(path, expected_columns, expected_domain = NULL) {
  if (!file.exists(path)) {
    cli::cli_abort("Concept file not found: {.path {path}}")
  }

  concepts <- utils::read.csv(
    path,
    stringsAsFactors = FALSE,
    check.names = FALSE
  )

  missing_columns <- setdiff(expected_columns, names(concepts))
  if (length(missing_columns) > 0) {
    cli::cli_abort(c(
      "Invalid concept file: {.path {path}}.",
      "x" = "Missing column{?s}: {paste(missing_columns, collapse = ', ')}."
    ))
  }

  concept_ids <- suppressWarnings(as.integer(concepts$concept_id))
  invalid_ids <- is.na(concept_ids) | concept_ids <= 0
  if (any(invalid_ids)) {
    cli::cli_abort(c(
      "Invalid concept file: {.path {path}}.",
      "x" = "All concept_id values must be positive integers."
    ))
  }

  if (anyDuplicated(concept_ids)) {
    cli::cli_abort(c(
      "Invalid concept file: {.path {path}}.",
      "x" = "concept_id values must be unique."
    ))
  }

  if (!is.null(expected_domain) && any(concepts$domain_id != expected_domain)) {
    cli::cli_abort(c(
      "Invalid concept file: {.path {path}}.",
      "x" = "Every domain_id must be {expected_domain}."
    ))
  }

  sort(concept_ids)
}

mi_concept_ids <- read_concept_ids(
  path = here("codelist", "mi_concepts.csv"),
  expected_columns = c(
    "concept_id",
    "concept_name",
    "domain_id",
    "vocabulary_id",
    "standard_concept"
  ),
  expected_domain = "Condition"
)

beta_blocker_concept_ids <- read_concept_ids(
  path = here("codelist", "beta_blockers.csv"),
  expected_columns = "concept_id"
)

mi_concept_set <- list("Myocardial infarction" = mi_concept_ids)
beta_blocker_concept_set <- list(
  "Beta blocker exposure" = beta_blocker_concept_ids
)
