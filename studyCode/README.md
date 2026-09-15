# Study Code

This folder contains the complete post-MI beta-blocker study.

## Design

The study uses three ordinary event cohorts:

- `mi_events` is the target cohort;
- `beta_blocker_events` is the outcome cohort; and
- `death_events` is the competing-outcome cohort.

The single-event analysis estimates time from MI to the first subsequent
beta-blocker exposure record. Its survival estimate is the probability of not
yet having a beta-blocker record; it is not all-cause patient survival. The
competing-risk analysis estimates beta-blocker cumulative incidence while
treating death as a competing event. Prior beta-blocker exposure does not
exclude a person from the analysis.

The treatment definition describes recorded exposure, not confirmed dispensing
or adherence. The results are descriptive and should not be interpreted as a
causal treatment effect.

## Files

- `codeToRun.R` contains empty database-connection placeholders for each data
  partner to complete.
- `codelist/` contains the supplied MI and beta-blocker concept sets.
- `cohorts/instantiateCohorts.R` constructs MI, beta-blocker, and death event
  cohorts.
- `analyses/` contains cohort-characteristic and survival analyses.
- `Results/` receives the disclosure-controlled summarised-result CSV.

## Instructions

For detailed instructions on how to run the study code, please see the [INSTRUCTIONS.md](../INSTRUCTIONS.md) file in the root directory of this repository.
