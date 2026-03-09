# HippoTail Agent Context

This file is the only document placed in ChatGPT project context.
All other files must be loaded from GitHub using fetch_file.

This file is the master entry point for the HippoTail agent lab.

Agents must begin by reading only the files relevant to their task.
Do not load the entire repository unless explicitly instructed.

---

# Repository

Repository name:

HippoTail

All repository files must be accessed using repository paths and the GitHub connector.

Example:

fetch_file(repository_name="HippoTail", path="docs/Hypotheses.md", ref="main")

Agents must not use GitHub browser URLs to access files.

---

# Core startup files

Agents must read these first:

docs/HippoTail_OperatingSystem.md  
docs/HippoTail_ProjectBible.md  
docs/DAVID_weekly_agenda.md

These define:

- project rules
- scientific scope
- current priorities

Example fetch commands:

fetch_file(repository_name="HippoTail", path="docs/HippoTail_OperatingSystem.md", ref="main")

fetch_file(repository_name="HippoTail", path="docs/HippoTail_ProjectBible.md", ref="main")

fetch_file(repository_name="HippoTail", path="docs/DAVID_weekly_agenda.md", ref="main")

---

# Human-controlled files

These files are edited only by the human PI (David):

docs/DAVID_weekly_agenda.md  
docs/DAVID_meeting_schedule.md  
docs/DAVID_decisions_log.md

Agents may read these files but must never modify them.

---

# Agent-owned files

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

# Literature ingestion

Weekly literature reports are stored in:

lit/weekly_litReport_YYYYMMDD.txt

LitBoss responsibilities:

- ingest new literature reports
- update docs/Literature_Map.md
- summarize relevant findings in docs/weekly_report.md
- propose new literature queries if gaps are detected

---

# Contracts

Analysis completion is defined by files in:

contracts/

Key initial contracts:

contracts/CONTRACT_replicate6c6d.md  
contracts/CONTRACT_HippoTail_contrasts.md

Agents may not declare an analysis complete unless the relevant contract acceptance criteria are satisfied.

---

# Experiment Radar

Experiment prioritization is managed in:

docs/Experiment_Radar.md

ResearchScientist must review the radar before proposing new experiments.

The radar ranks experiments based on:

- hypothesis impact
- data readiness
- feasibility
- publication potential

---

# Context discipline

Agents must load only what they need.

## Research tasks may read

docs/HippoTail_OperatingSystem.md  
docs/HippoTail_ProjectBible.md  
docs/DAVID_weekly_agenda.md  
docs/Hypotheses.md  
docs/Literature_Map.md  
docs/Critic_Report.md  
docs/Experiment_Radar.md

## Design tasks may read

docs/Study_Design.md  
docs/Hypotheses.md  
docs/Literature_Map.md  
docs/Critic_Report.md

## Data tasks may read

docs/Data_Structure.md  
docs/Study_Design.md  
docs/Analysis_Plan.md

## Analysis tasks may read

docs/Analysis_Plan.md  
docs/Data_Structure.md  
contracts/  
results/  
figures/

Agents should avoid loading unrelated documents.

---

# Mission

The mission of the HippoTail agent lab is to:

- discover meaningful hippocampal tail connectivity patterns using CCEP data
- generate reproducible analyses
- refine hypotheses iteratively
- produce publishable neuroscience
