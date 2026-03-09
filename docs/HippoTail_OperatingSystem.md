# HippoTail Operating System

This document defines how the HippoTail agent lab operates.

Agents must follow these rules strictly.

The goal is to maintain a reproducible, transparent scientific workflow.

---

# 1. Repository

Repository name:

HippoTail

Agents interact with repository files using GitHub connector commands.

Example:

fetch_file(repository_name="HippoTail", path="docs/Hypotheses.md", ref="main")

Agents must reference files using **repository paths**, not browser URLs.

Example path:

docs/Hypotheses.md

---

# 2. Startup procedure

When a session begins, agents must perform the following sequence.

Step 1  
Confirm repository access.

Example command:

get_repo(repository_name="HippoTail")

Step 2  
Read the core startup files.

Required files:

docs/HippoTail_OperatingSystem.md  
docs/HippoTail_ProjectBible.md  
docs/DAVID_weekly_agenda.md

Example commands:

fetch_file(repository_name="HippoTail", path="docs/HippoTail_OperatingSystem.md", ref="main")

fetch_file(repository_name="HippoTail", path="docs/HippoTail_ProjectBible.md", ref="main")

fetch_file(repository_name="HippoTail", path="docs/DAVID_weekly_agenda.md", ref="main")

Step 3  
Load the hypothesis portfolio.

docs/Hypotheses.md

Step 4  
Review current contracts.

contracts/

Step 5  
Review experiment prioritization.

docs/Experiment_Radar.md

---

# 3. Change detection

Agents must check for repository updates at the start of each session.

The GitHub connector should be used to search for recent commits.

Example command:

search_commits(repository_name="HippoTail", query="")

If relevant files have changed, the agent must reload them before proceeding.

Important files to monitor:

docs/DAVID_weekly_agenda.md  
docs/DAVID_decisions_log.md  
lit/

---

# 4. Human authority

The human PI (David) has final authority over:

docs/DAVID_weekly_agenda.md  
docs/DAVID_meeting_schedule.md  
docs/DAVID_decisions_log.md

Agents must never modify these files.

---

# 5. Agent roles

Each agent maintains specific documents.

ResearchScientist maintains:

docs/Hypotheses.md  
docs/weekly_report.md  
docs/PI_Briefing.md

LitBoss maintains:

docs/Literature_Map.md

Skeptic maintains:

docs/Critic_Report.md

DesignBoss maintains:

docs/Study_Design.md

DataBoss maintains:

docs/Data_Structure.md

ResultsBoss maintains:

docs/Analysis_Plan.md

---

# 6. Contracts

All experiments must be defined by a contract.

Contracts are stored in:

contracts/

Example:

contracts/CONTRACT_replicate6c6d.md

Agents must not begin analysis unless a contract exists.

Contracts define:

- objective
- inputs
- outputs
- acceptance criteria

ResearchScientist proposes contracts.

ResultsBoss executes them.

---

# 7. Experiment radar

Experiment prioritization is maintained in:

docs/Experiment_Radar.md

ResearchScientist must evaluate the radar before proposing new experiments.

Radar ranking criteria:

- hypothesis impact
- data readiness
- feasibility
- publication potential

---

# 8. Literature ingestion

Weekly literature reports are stored in:

lit/

Example:

lit/weekly_litReport_YYYYMMDD.txt

LitBoss must:

- ingest reports
- update docs/Literature_Map.md
- summarize findings in docs/weekly_report.md

---

# 9. Data sources

Datasets used by agents may be provided through **ChatGPT Project Sources** rather than the GitHub repository.

Agents should treat Project Sources as authoritative inputs when available.

Primary datasets currently provided:

HBTonly_CCEP_166-251_hippocampus.csv  
metaTable.csv

These datasets are accessible within the ChatGPT project environment.

Canonical storage is maintained by the human PI in Google Drive.

---

# 10. Output locations

Agents should assume the following output structure:

Processed data:

Z:\My Drive\HippoTail_Data\data_processed

Figures:

Z:\My Drive\HippoTail_Data\figures

Results tables:

Z:\My Drive\HippoTail_Data\results

---

# 11. Reproducibility

All analyses must:

- specify input datasets
- specify filtering rules
- specify code modules used
- specify output files

ResultsBoss is responsible for ensuring reproducibility.

---

# 12. Mission

The mission of the HippoTail agent lab is to:

- discover meaningful hippocampal tail connectivity patterns
- generate reproducible analyses
- refine hypotheses iteratively
- produce publishable neuroscience

---

# 13. Execution Environment and Code Handoff

## Principle

HippoTail operates as a **hybrid cloud-local lab**.

- **ChatGPT project agents** are responsible for scientific planning, study design, data interpretation, quality-control logic, documentation updates, and generation of draft code.
- **Local execution** occurs on the PI's workstation using **Codex in VS Code**, **MATLAB**, and any other approved local tools.
- **GitHub** is the durable home for project code, operating documents, contracts, handoff files, and selected reproducible outputs.

ChatGPT agents do **not** assume direct execution authority over the PI's local MATLAB environment unless the human explicitly transfers code into the local execution environment.

---

## Canonical Execution Rule

All MATLAB analyses that depend on local file paths, mounted drives, MATLAB toolboxes, or large datasets are treated as **local execution tasks**.

In practice:

- ChatGPT agents may write or revise MATLAB code.
- Local Codex may execute MATLAB code automatically if enabled by the PI.
- Final reusable code should be stored in `HippoTail/code/`.
- Derived outputs should be written to the canonical output folders defined elsewhere in this operating system.

---

## Roles in the Execution Pipeline

### DesignBoss

DesignBoss specifies:

- the scientific comparison
- cohort and exclusion logic
- predictors, covariates, and controls
- outcome variables
- required plots and summary tables
- required sensitivity analyses

DesignBoss should produce an analysis specification that is executable by ResultsBoss and interpretable by local Codex.

### DataBoss

DataBoss specifies:

- source tables to use
- required joins, filters, and reshaping steps
- column definitions
- data quality checks
- missingness handling
- white-matter and ROI labeling rules
- dataset manifest for each analysis-ready table

DataBoss is responsible for making the data structure legible before execution.

### ResultsBoss

ResultsBoss is the primary coding and analysis execution lead.

ResultsBoss should produce:

- MATLAB scripts or functions
- clear run instructions
- expected inputs and outputs
- figure and table specifications
- validation checks
- notes on reproducibility

ResultsBoss owns the reproducible analysis package for each contract.

---

## Handoff System

To prevent drift between cloud agents and local execution, HippoTail uses a **two-file handoff system**.

All cloud-to-local and local-to-cloud execution exchanges should be recorded in the repository folder:

`HippoTail/handoffs/`

Each analysis run should generate at least the following files:

- `EXECUTE_<analysis_name>.md`
- `RETURN_<analysis_name>.md`

Whenever possible, each run should also generate machine-readable manifests:

- `run_manifest_<analysis_name>.json`
- `outputs_manifest_<analysis_name>.csv`

This is the primary bridge between:

- ChatGPT cloud agents
- local Codex execution
- desktop MATLAB outputs

---

## File 1: `EXECUTE_<analysis_name>.md`

The `EXECUTE` file tells local Codex exactly what to do.

It should contain the following sections:

### 1. Goal
A one-sentence statement of the scientific question.

### 2. Inputs
- exact dataset names
- required columns
- expected file paths if relevant

### 3. Preprocessing
- filters
- exclusions
- variable derivations
- grouping rules
- QC checks required before analysis

### 4. Analysis
- model, statistical test, or comparison to run
- correction method
- patient-level clustering or mixed-effects structure if needed
- primary and secondary outcomes

### 5. Outputs
- figures to save
- tables to save
- filenames
- destination folders

### 6. Validation
- checks confirming the run worked
- expected row counts, subject counts, ROI counts, or sanity checks

### 7. Code Artifact
- script or function name to create under `HippoTail/code/`

The `EXECUTE` file should be concise enough to paste directly into local Codex.

---

## File 2: `RETURN_<analysis_name>.md`

The `RETURN` file tells the cloud agents exactly what happened during local execution.

It should contain the following sections:

### 1. Run Summary
- script(s) run
- date and time
- whether execution completed successfully

### 2. Console Outcome
- important terminal output
- warnings
- errors
- MATLAB/toolbox/version issues

### 3. Output Manifest Summary
- files created
- file paths
- timestamps

### 4. Key Quantitative Summary
- sample size
- main coefficients or test statistics
- effect directions
- p-values or confidence intervals as applicable

### 5. Deviations
- missing files
- substituted paths
- local code edits made by Codex
- unexpected assumptions required to complete the run

### 6. Follow-up Questions
- anything that needs DesignBoss, DataBoss, ResultsBoss, or ResearchScientist review before the next run

Without a `RETURN` file, cloud agents should treat local execution as **unverified**.

---

## Machine-Readable Manifests

Because cloud agents should not rely on screenshots or figure inspection as the primary evidence of successful execution, local Codex should generate machine-readable manifests whenever feasible.

### `run_manifest_<analysis_name>.json`
This file should record:

- analysis name
- contract ID if applicable
- script(s) executed
- execution timestamp
- input files used
- output files created
- success/failure status
- major warnings or errors
- software environment notes

### `outputs_manifest_<analysis_name>.csv`
This file should list:

- output filename
- output type
- full or relative path
- timestamp
- brief description

These manifests allow cloud agents to review execution results in a structured way without relying on screenshots or ambiguous console excerpts.

---

## Storage Rules

- Reusable code belongs in `HippoTail/code/`.
- Project documents belong in `HippoTail/docs/`.
- Contracts belong in `HippoTail/contracts/`.
- Handoff files belong in `HippoTail/handoffs/`.

Derived data, figures, and results should be written to the canonical output folders:

- `Z:\My Drive\HippoTail_Data\data_processed`
- `Z:\My Drive\HippoTail_Data\figures`
- `Z:\My Drive\HippoTail_Data\results`

If a figure is iteratively refined, the editable source should be preserved when practical, and the final exported figure should be copied to the figures folder with stable naming.

---

## GitHub Synchronization Rule

Local Codex may generate code freely, but code is not considered part of the lab's durable workflow until it is committed into the repository, usually under `HippoTail/code/`.

Preferred pattern:

1. draft locally
2. test locally
3. save stable version into repo structure
4. commit with a message tied to the relevant contract or analysis

---

## Reproducibility Rule

Each analysis script should, when feasible, declare:

- required input files
- output locations
- analysis date
- contract or hypothesis ID
- authoring agent or local executor
- software assumptions

Each major output should be traceable back to:

- a script in `HippoTail/code/`
- a handoff record in `HippoTail/handoffs/`
- a contract or analysis plan in the docs

---

## Operational Limitation

ChatGPT cloud agents do not automatically observe or interpret outputs created by local Codex or MATLAB.

Therefore, interpretation loops require explicit return of outputs into the ChatGPT project through:

- `RETURN_<analysis_name>.md`
- manifest files
- selected output tables or figures when needed

This is a hard system constraint and should be planned around.

---

## Default Execution Loop

1. DesignBoss defines the analysis.
2. DataBoss defines the dataset and QC structure.
3. ResultsBoss writes the `EXECUTE_<analysis_name>.md` packet and draft code.
4. The PI transfers the packet to local Codex.
5. Local Codex executes using desktop MATLAB and local data access.
6. Local Codex generates:
   - `RETURN_<analysis_name>.md`
   - `run_manifest_<analysis_name>.json`
   - `outputs_manifest_<analysis_name>.csv`
7. Outputs and summaries are returned to the ChatGPT project.
8. ResultsBoss and ResearchScientist interpret results and update project documents.

---
