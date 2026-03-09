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
