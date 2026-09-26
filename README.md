# Beta blockers after myocardial infarction
<img src="https://img.shields.io/badge/Study%20Status-Started-blue.svg" alt="Study Status: Started">

- **Study title**: Beta blockers after myocardial infarction
- **Study start date**: 2026-05-12
- **Study leads**: [Add study leads]
- **Study end date**: [Ongoing]
- **Publications**: [None yet]

## Study description

This OHDSI study describes when beta-blocker exposure is recorded after a
myocardial infarction (MI). The study estimates:

- time from an MI event to a subsequent beta-blocker exposure record;
- cumulative incidence of beta-blocker exposure after MI, with death treated
  as a competing event; and
- MI cohort counts, attrition, and demographics.

MI events are the target cohort. Beta-blocker exposure events are the outcome.
The analysis is descriptive and does not estimate a treatment effect.

This repository is the worked application example for the
[CohortSurvival](https://darwin-eu.github.io/CohortSurvival/) R package. It
shows a complete network-study workflow, from constructing OMOP CDM cohorts to
exporting and interactively reviewing standardised aggregate results.

## Study design

- **Target:** the first eligible MI event in an adult after 365 days of prior
  observation, with no MI in the preceding 28 days.
- **Outcome:** the first recorded beta-blocker exposure after MI. Previous
  beta-blocker use is allowed, so the outcome washout is intentionally zero.
- **Competing event:** death.
- **Follow-up:** 365 days after the MI event.
- **Analyses:** a single-event survival analysis and a competing-risk analysis,
  stored as separate results.

---

## Repository organization

This repository is organised as follows:

- **[studyCode](studyCode/)**: Contains the main study analysis code
- **[studyShiny](studyShiny/)**: Shiny app for exploring study results

The supplied concept sets are versioned in `studyCode/codelist/`:

- `mi_concepts.csv`: 127 MI concepts supplied for this study.
- `beta_blockers.csv`: 27,507 beta-blocker concepts supplied for this study.

---

For detailed instructions on how to run the study, please see the [INSTRUCTIONS.md](./INSTRUCTIONS.md) file.

---

*This study template was generated using [OmopStudyBuilder](https://oxford-pharmacoepi.github.io/OmopStudyBuilder/).*
