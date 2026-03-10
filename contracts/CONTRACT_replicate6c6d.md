CONTRACT_replicate6c6d.md

# CONTRACT_replicate6c6d

## Title
Replicate Lyu et al. Figure 6c–d and Supplementary Tables S2–S3 from metaTable.csv

## Purpose
Establish that the HippoTail analysis pipeline can reproduce the published thalamocortical feature-map results from Lyu et al. before adapting the workflow to hippocampal head/body/tail analyses.

## Scientific objective
Using `metaTable.csv` and the code/resources in `code/Lyu` (modifying as necessary), reproduce:

- Figure 6c
- Figure 6d
- Supplementary Table S2
- Supplementary Table S3

from Lyu et al. Nature Neuroscience 2025.

## Why this contract matters
This is the primary methodological blocker for the project. HippoTail-specific maps should not be interpreted until the Lyu replication pipeline is working.

## Inputs
Primary data:
- `metaTable.csv`

Reference materials:
- `Lyu Parvizi Nature Neuro 2025.pdf`
- `Lyu Parvizi Nature Neuro 2025 supplement.pdf`
- `TableS2_Lyu.xlsx`
- `TableS3_Lyu.xlsx`
- figure reference image for Lyu Fig 6c–d

Code/resources:
- `code/Lyu/`

## Scope
This contract covers replication using `metaTable.csv` only.

This contract does NOT yet include:
- hippocampal head/body/tail analyses in `HBTonly_CCEP_166-251_hippocampus.csv`
- new biological interpretation for HippoTail
- white-matter sensitivity analyses for HBT
- final manuscript-grade figures for HippoTail

## Required agent workflow

### ResearchScientist
- define the exact replication target
- supervise DesignBoss, DataBoss, ResultsBoss
- decide whether the replication is sufficiently faithful to proceed

### DesignBoss
Define:
- what counts as Fig 6c replication
- what counts as Fig 6d replication
- what exact comparisons are represented in Tables S2 and S3
- what subset logic, filters, and inclusion/exclusion criteria are needed

### DataBoss
Define:
- all required columns in `metaTable.csv`
- mapping of rows/fields to:
  - thalamic subdivision
  - inflow vs outflow
  - feature F1
  - ROI labels
  - subject identifier
- any preprocessing/QC rules
- any ambiguity in region labels or feature encodings

### ResultsBoss
Deliver:
- executable analysis plan
- reusable code under `code/`
- handoff packet in `handoffs/EXECUTE_replicate6c6d.md`

## Required outputs
Minimum required outputs:

### Figures
- `figures/Lyu_replication_fig6c.png`
- `figures/Lyu_replication_fig6d.png`

### Tables
- `results/Lyu_replication_TableS2.csv`
- `results/Lyu_replication_TableS3.csv`

### Run summary
- `handoffs/RETURN_replicate6c6d.md`

Whenever feasible:
- `handoffs/run_manifest_replicate6c6d.json`
- `handoffs/outputs_manifest_replicate6c6d.csv`

## Acceptance criteria
This contract is complete only if all of the following are true:

1. A reproducible script or code path is identified and run from `metaTable.csv`
2. Figure 6c is reproduced with the same qualitative regional pattern and matching comparison structure
3. Figure 6d is reproduced with the same qualitative regional pattern and matching comparison structure
4. Supplementary Table S2 is reproduced with the same statistical target as the paper
5. Supplementary Table S3 is reproduced with the same statistical target as the paper
6. Any deviations from published values are explicitly documented
7. ResultsBoss states whether the pipeline is sufficiently faithful to transfer to HBT
8. ResearchScientist signs off that the blocker is cleared

## Failure conditions
This contract is NOT complete if:
- only visual similarity is claimed without documented code/data provenance
- the wrong subset of rows or wrong thalamic grouping is used
- the pipeline cannot be traced from input data to output figures/tables
- local execution occurred but no return artifact was produced

## Next contract after completion
If this contract is accepted, immediately start:
- transfer of the validated selection logic and filters to `HBTonly_CCEP_166-251_hippocampus.csv`
- generation of first HippoTail connectivity maps and contrasts
