# Study Shiny app

This app explores the aggregate results from the post-MI beta-blocker study.
It uses OmopViewer's supported upload workflow, with the single-event and
competing-risk results kept in their own result panels. The optional global
summary tab is disabled.

## Run locally

1. Install `shiny` and `OmopViewer`.
2. Open `studyShiny.Rproj` in RStudio.
3. Run `shiny::runApp()`.
4. Upload one or more disclosure-controlled CSVs produced by `studyCode/runStudy.R`.
5. Select the files and click **Bind data and load app**.

The app does not accept or retain patient-level data. For the complete study
workflow, see [INSTRUCTIONS.md](../INSTRUCTIONS.md).
