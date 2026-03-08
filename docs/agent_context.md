# HippoTail Agent Context

This file is the master entry point for the HippoTail agent lab.

Agents must begin by reading only the files relevant to their task.
Do not load the entire repository unless explicitly instructed.

---

## Core startup files

Read these first:

1. `docs/HippoTail_OperatingSystem.md`
2. `docs/HippoTail_ProjectBible.md`
3. `docs/DAVID_weekly_agenda.md`

These define:
- project rules
- scientific scope
- current priorities

---

## Human-controlled files

These files are edited only by David:

- `docs/DAVID_weekly_agenda.md`
- `docs/DAVID_meeting_schedule.md`
- `docs/DAVID_decisions_log.md`

Agents may read them but must never modify them.

---

## Agent-owned files

ResearchScientist maintains:
- `docs/Hypotheses.md`
- `docs/Weekly_Report.md`
- `docs/PI_Briefing.md`
- `docs/Research_Log.md`

LitBoss maintains:
- `docs/Literature_Map.md`

Skeptic maintains:
- `docs/Critic_Report.md`

DesignBoss maintains:
- `docs/Study_Design.md`

DataBoss maintains:
- `docs/Data_Structure.md`

ResultsBoss maintains:
- `docs/Analysis_Plan.md`

---

## Literature ingestion

Weekly literature reports are stored in:

- `lit/weekly_litReport_YYYYMMDD.txt`
- `lit/weekly_litReport_YYYYMMDD.md`

LitBoss is responsible for:
- ingesting these reports
- updating `docs/Literature_Map.md`
- writing literature findings and recommended next queries into `docs/Weekly_Report.md`

---

## Contracts

Analysis completion is defined by files in:

- `contracts/`

Agents may not declare an analysis complete unless the relevant contract is satisfied.

---

## Context discipline

Agents must load only what they need.

### Research tasks may read:
- `docs/HippoTail_OperatingSystem.md`
- `docs/HippoTail_ProjectBible.md`
- `docs/DAVID_weekly_agenda.md`
- `docs/Hypotheses.md`
- `docs/Literature_Map.md`
- `docs/Critic_Report.md`

### Design tasks may read:
- `docs/Study_Design.md`
- `docs/Hypotheses.md`
- `docs/Literature_Map.md`
- `docs/Critic_Report.md`

### Data tasks may read:
- `docs/Data_Structure.md`
- `docs/Study_Design.md`
- `docs/Analysis_Plan.md`

### Analysis tasks may read:
- `docs/Analysis_Plan.md`
- `docs/Data_Structure.md`
- relevant files in `contracts/`
- relevant files in `results/`
- relevant files in `figures/`

Do not load unrelated files.

---

## Mission

The mission of the HippoTail agent lab is to:

- discover meaningful hippocampal tail connectivity patterns using CCEP data
- generate reproducible analyses
- refine hypotheses iteratively
- produce publishable neuroscience
