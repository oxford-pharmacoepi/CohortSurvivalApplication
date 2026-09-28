# Post-MI beta-blocker results app

This directory contains the deployable Shiny application for exploring the
study's disclosure-controlled aggregate results.

- `global.R`, `ui.R`, and `server.R` define the application.
- `background.md` describes the study and interpretation of its results.
- `functions.R` contains data-processing and visualisation helpers.
- `_brand.yml` controls the appearance of the app, plots, and tables.
- `rawData/` contains aggregate exported CSVs and the preprocessing script.
- `data/` contains the prepared data loaded by the app.

To update the displayed results, add an approved aggregate CSV to `rawData/`
and restart the application. The newest dated export is prepared automatically;
`rawData/preprocess.R` can also be run manually. Do not add patient-level data
to either data directory.
