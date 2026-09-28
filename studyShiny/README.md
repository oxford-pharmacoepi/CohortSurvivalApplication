# Study Shiny app

The complete OmopViewer-generated application is in `shiny/`. It presents the
aggregate results from the post-MI beta-blocker study, with single-event and
competing-risk results selected separately.

## Run locally

1. Open `studyShiny/shiny/shiny.Rproj` in RStudio.
2. Install the packages loaded by `shiny/global.R` if needed.
3. Run `shiny::runApp("shiny")` from the `studyShiny` directory, or
   `shiny::runApp()` from inside `studyShiny/shiny`.

The app uses the prepared aggregate data in `shiny/data/`. See
[INSTRUCTIONS.md](../INSTRUCTIONS.md) for the complete study workflow.
