library(shiny)
library(OmopViewer)

viewer_app <- launchDynamicApp()

ui <- tagList(
  tags$head(
    tags$link(rel = "stylesheet", type = "text/css", href = "style.css"),
    tags$script(HTML(
      "const brandApp = () => {
         const brand = document.querySelector('.navbar-brand');
         if (!brand) return;
         const logo = brand.querySelector('img');
         if (logo) {
           logo.src = 'https://raw.githubusercontent.com/darwin-eu/CohortSurvival/main/man/figures/logo.png';
           logo.alt = 'CohortSurvival logo';
         }
         for (const node of brand.childNodes) {
           if (node.nodeType === Node.TEXT_NODE && node.textContent.trim()) {
             node.textContent = ' Post-MI beta-blocker study';
           }
         }
         const summary = document.querySelector('#configuration_summary');
         if (summary && summary.checked) summary.click();
       };
       new MutationObserver(brandApp).observe(document.documentElement, {
         childList: true,
         subtree: true
       });
       document.addEventListener('shiny:connected', brandApp);"
    ))
  ),
  uiOutput("ui")
)

shinyApp(
  ui = ui,
  server = viewer_app$serverFuncSource()
)
