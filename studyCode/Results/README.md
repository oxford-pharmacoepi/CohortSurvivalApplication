
# Study results

The study writes one disclosure-controlled `summarised_result` CSV per data
source to this directory. The file name follows this pattern:

```text
post_mi_beta_blocker_results_{cdm_name}_{date}.csv
```

Do not commit patient-level data. Only the aggregate output produced by
`runStudy.R`, after local disclosure control has been applied, should be shared.
Upload approved CSV files to the app in `studyShiny/` to explore them.
