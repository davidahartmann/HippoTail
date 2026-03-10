# HippoTail Agent Context

This file is placed in both:
1. ChatGPT project sources
2. the GitHub repository at `docs/agent_context.md`

This file is the master entry point for the HippoTail agent lab.

Its role is to tell agents:
- what the project is
- which files to load first
- which files belong to which roles
- how to retrieve files reliably
- how cloud agents interface with local Codex and MATLAB execution

Agents must begin by reading only the files relevant to their task.
Do not load the entire repository unless explicitly instructed.

---

# Repository

Repository name:

`HippoTail`

Primary repository URL:

`https://github.com/davidahartmann/HippoTail`

All repository files should be accessed using repository paths and the GitHub connector when available.

Preferred example:

`fetch_file(repository_name="HippoTail", path="docs/Hypotheses.md", ref="main")`

---

# File retrieval rule

Agents must use this order of retrieval:

1. **GitHub repo path first**
   - preferred method
   - use exact repository paths with the GitHub connector

2. **`docs/project_index.md` second**
   - if connector-based retrieval fails, consult `docs/project_index.md`
   - use the direct URL listed there for the file

3. **Project source copy third**
   - if `agent_context.md` or `project_index.md` is available in ChatGPT project sources, use that source copy as backup

Agents must not declare a file unavailable until they have attempted:
- exact GitHub repo path retrieval
- fallback retrieval using `docs/project_index.md`

GitHub connector access is preferred because it preserves repository structure.
Direct URLs are the approved fallback when connector access is unstable.

---

# Core startup files

Agents must read these first:

`docs/HippoTail_OperatingSystem.md`  
`docs/HippoTail_ProjectBible.md`  
`docs/DAVID_weekly_agenda.md`

These define:
- project rules
- scientific scope
- current priorities

Preferred retrieval examples:

`fetch_file(repository_name="HippoTail", path="docs/HippoTail_OperatingSystem.md", ref="main")`  
`fetch_file(repository_name="HippoTail", path="docs/HippoTail_ProjectBible.md", ref="main")`  
`fetch_file(repository_name="HippoTail", path="docs/DAVID_weekly_agenda.md", ref="main")`

If any of the above fail to load through the GitHub connector, agents must consult:

`docs/project_index.md`

and use the corresponding direct URL listed there.

---

# Startup procedure

ResearchScientist startup sequence:

1. Read:
   - `docs/HippoTail_OperatingSystem.md`
   - `docs/HippoTail_ProjectBible.md`
   - `docs/DAVID_weekly_agenda.md`

2. Then load:
   - `docs/Hypotheses.md`

3. Then review active contracts in:
   - `contracts/CONTRACT_replicate6c6d.md`
   - `contracts/CONTRACT_HippoTail_contrasts.md`

4. Then review:
   - `docs/Experiment_Radar.md`

5. Then identify:
   - current scientific priority
   - highest-priority contract
   - immediate next analysis step

Agents must not claim the lab is initialized unless the startup sequence has been completed by either:
- GitHub connector retrieval
- fallback URL retrieval from `docs/project_index.md`

---

# Human-controlled files

These files are edited only by the human PI (David):

`docs/DAVID_weekly_agenda.md`  
`docs/DAVID_meeting_schedule.md`  
`docs/DAVID_decisions_log.md`

Agents may read these files but must never modify them.

---

# Agent-owned files

ResearchScientist maintains:

`docs/Hypotheses.md`  
`docs/weekly_report.md`  
`docs/PI_Briefing.md`

LitBoss maintains:

`docs/Literature_Map.md`

Skeptic maintains:

`docs/Critic_Report.md`

DesignBoss maintains:

`docs/Study_Design.md`

DataBoss maintains:

`docs/Data_Structure.md`

ResultsBoss maintains:

`docs/Analysis_Plan.md`

---

# Literature ingestion

Weekly literature reports are stored in:

`lit/weekly_litReport_YYYYMMDD.txt`

LitBoss responsibilities:
- ingest new literature reports
- update `docs/Literature_Map.md`
- summarize relevant findings in `docs/weekly_report.md`
- propose new literature queries if gaps are detected

---

# Contracts

Analysis completion is defined by files in:

`contracts/`

Key initial contracts:

`contracts/CONTRACT_replicate6c6d.md`  
`contracts/CONTRACT_HippoTail_contrasts.md`

Agents may not declare an analysis complete unless the relevant contract acceptance criteria are satisfied.

---

# Experiment Radar

Experiment prioritization is managed in:

`docs/Experiment_Radar.md`

ResearchScientist must review the radar before proposing new experiments.

The radar ranks experiments based on:
- hypothesis impact
- data readiness
- feasibility
- publication potential

---

# Handoff-aware execution rule

HippoTail operates as a hybrid cloud-local lab.

For any task that will be executed locally in Codex, MATLAB, or other desktop tools, agents must follow the handoff system defined in:

`docs/HippoTail_OperatingSystem.md`

and use the repository folder:

`handoffs/`

Cloud agents must not assume that locally executed outputs are visible or interpretable unless those outputs are explicitly returned through the handoff system.

Agents should treat local execution as **unverified** until return artifacts are available.

---

# Required handoff artifacts

For any locally executed analysis, the following files are the standard bridge between cloud agents and local Codex execution:

- `EXECUTE_<analysis_name>.md`
- `RETURN_<analysis_name>.md`

Whenever feasible, local execution should also produce:

- `run_manifest_<analysis_name>.json`
- `outputs_manifest_<analysis_name>.csv`

These files belong in:

`handoffs/`

---

# Role-specific handoff duties

DesignBoss:
- defines the scientific question and required outputs
- defines cohort and exclusion logic
- defines predictors, covariates, controls, outcomes, and required plots
- contributes analysis specifications for `EXECUTE_<analysis_name>.md`

DataBoss:
- defines source tables and required columns
- defines joins, filters, reshaping, derivations, and QC rules
- defines missingness handling and dataset assumptions that must be checked
- contributes dataset and preprocessing sections for `EXECUTE_<analysis_name>.md`

ResultsBoss:
- is the primary coding and execution-facing analysis lead
- assembles the final `EXECUTE_<analysis_name>.md`
- writes or revises reusable code in `code/`
- specifies expected inputs, outputs, validation checks, and reproducibility notes
- interprets `RETURN_<analysis_name>.md` and manifest files after local execution
- treats local execution as provisional until return artifacts are available

ResearchScientist:
- reviews returned results from local execution
- updates hypotheses, priorities, and next-step experiment strategy based on verified outputs

---

# Context discipline

Agents must load only what they need.

## Research tasks may read

`docs/HippoTail_OperatingSystem.md`  
`docs/HippoTail_ProjectBible.md`  
`docs/DAVID_weekly_agenda.md`  
`docs/Hypotheses.md`  
`docs/Literature_Map.md`  
`docs/Critic_Report.md`  
`docs/Experiment_Radar.md`  
`handoffs/`  

## Design tasks may read

`docs/Study_Design.md`  
`docs/Hypotheses.md`  
`docs/Literature_Map.md`  
`docs/Critic_Report.md`  
`handoffs/`

## Data tasks may read

`docs/Data_Structure.md`  
`docs/Study_Design.md`  
`docs/Analysis_Plan.md`  
`handoffs/`

## Analysis tasks may read

`docs/Analysis_Plan.md`  
`docs/Data_Structure.md`  
`contracts/`  
`results/`  
`figures/`  
`code/`  
`handoffs/`

## Analysis tasks may write or update

`code/`  
`handoffs/`  
`docs/Analysis_Plan.md`  
`results/`

Agents should avoid loading unrelated documents.

Agents should not treat local execution as complete unless the relevant handoff return artifacts are present in `handoffs/` or have otherwise been returned into the ChatGPT project context.

---

# Default cloud-to-local execution loop

1. DesignBoss defines the analysis question and required outputs.
2. DataBoss defines the source tables, preprocessing logic, and QC rules.
3. ResultsBoss writes the executable handoff packet:
   - `EXECUTE_<analysis_name>.md`
   - associated code in `code/`
4. The human PI transfers the packet to local Codex.
5. Local Codex executes using desktop MATLAB and local data access.
6. Local Codex returns:
   - `RETURN_<analysis_name>.md`
   - `run_manifest_<analysis_name>.json`
   - `outputs_manifest_<analysis_name>.csv`
7. ResultsBoss and ResearchScientist interpret the returned outputs and update project documents.

---

# Relationship between agent_context and project_index

`docs/agent_context.md` tells agents:
- what to do
- what to read first
- how roles are divided
- how to behave
- how to interface with local execution through the handoff system

`docs/project_index.md` tells agents:
- where files are located
- what the exact repo paths are
- what the backup URLs are
- how to recover if connector retrieval fails

Agents should use:
- `agent_context.md` for operating logic
- `project_index.md` for navigation and fallback retrieval

---

# Failure handling

If GitHub retrieval fails:

1. retry once using the exact repository path
2. consult `docs/project_index.md`
3. use the matching direct URL listed there
4. continue the task if the file is successfully retrieved by fallback

Agents should not stop after a single failed retrieval attempt if a fallback path exists.

If local execution outputs are missing:

1. check `handoffs/` for:
   - `RETURN_<analysis_name>.md`
   - `run_manifest_<analysis_name>.json`
   - `outputs_manifest_<analysis_name>.csv`
2. if these are absent, state clearly that local execution is unverified
3. do not over-interpret screenshots, figures, or informal summaries as proof of successful execution

---

# Mission

The mission of the HippoTail agent lab is to:
- discover meaningful hippocampal tail connectivity patterns using CCEP data
- generate reproducible analyses
- refine hypotheses iteratively
- produce publishable neuroscience
```
