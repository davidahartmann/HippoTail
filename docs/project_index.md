# HippoTail Project Index

This file is the stable navigation map for the HippoTail project.

It exists in two places:
1. on GitHub in `docs/project_index.md`
2. in ChatGPT project sources

Its purpose is to reduce failures when agents try to access repository files.

---

# Primary access rule

Agents should use this order of access:

1. **GitHub repo path first**
   - preferred when GitHub connector tools are working

2. **Direct GitHub URL second**
   - use the URL listed for the file if connector-based file access fails

3. **Project source copy third**
   - if this file or `agent_context.md` is available in ChatGPT project sources, use the uploaded copy as backup

Agents should not stop after one failed retrieval method if a backup path exists in this index.

---

# Startup rule

For startup, ResearchScientist must read these first:

1. `HippoTail/docs/HippoTail_OperatingSystem.md`
2. `HippoTail/docs/HippoTail_ProjectBible.md`
3. `HippoTail/docs/DAVID_weekly_agenda.md`

Then read, as needed:

4. `HippoTail/docs/Hypotheses.md`
5. `HippoTail/contracts/CONTRACT_replicate6c6d.md`
6. `HippoTail/contracts/CONTRACT_HippoTail_contrasts.md`
7. `HippoTail/docs/Experiment_Radar.md`

If GitHub connector access fails, use the corresponding URL listed below.

---

# Retrieval discipline

Agents must load only the files relevant to the current task.

Do not load the full repository unless explicitly instructed.

Prefer:
- startup files first
- contract files next
- analysis/data/code files only when needed for execution

---

# Root repository

Repository name: `HippoTail`  
Repository URL: `https://github.com/davidahartmann/HippoTail`

---

# Core startup files

## Operating system
github repo: `HippoTail/docs/HippoTail_OperatingSystem.md`  
URL: `https://github.com/davidahartmann/HippoTail/blob/main/docs/HippoTail_OperatingSystem.md`

## Project bible
github repo: `HippoTail/docs/HippoTail_ProjectBible.md`  
URL: `https://github.com/davidahartmann/HippoTail/blob/main/docs/HippoTail_ProjectBible.md`

## Weekly agenda
github repo: `HippoTail/docs/DAVID_weekly_agenda.md`  
URL: `https://github.com/davidahartmann/HippoTail/blob/main/docs/DAVID_weekly_agenda.md`

---

# High-priority scientific files

## Hypotheses
github repo: `HippoTail/docs/Hypotheses.md`  
URL: `https://github.com/davidahartmann/HippoTail/blob/main/docs/Hypotheses.md`

## Experiment radar
github repo: `HippoTail/docs/Experiment_Radar.md`  
URL: `https://github.com/davidahartmann/HippoTail/blob/main/docs/Experiment_Radar.md`

## Literature map
github repo: `HippoTail/docs/Literature_Map.md`  
URL: `https://github.com/davidahartmann/HippoTail/blob/main/docs/Literature_Map.md`

## Critic report
github repo: `HippoTail/docs/Critic_Report.md`  
URL: `https://github.com/davidahartmann/HippoTail/blob/main/docs/Critic_Report.md`

## Study design
github repo: `HippoTail/docs/Study_Design.md`  
URL: `https://github.com/davidahartmann/HippoTail/blob/main/docs/Study_Design.md`

## Analysis plan
github repo: `HippoTail/docs/Analysis_Plan.md`  
URL: `https://github.com/davidahartmann/HippoTail/blob/main/docs/Analysis_Plan.md`

## Data structure
github repo: `HippoTail/docs/Data_Structure.md`  
URL: `https://github.com/davidahartmann/HippoTail/blob/main/docs/Data_Structure.md`

## Weekly report
github repo: `HippoTail/docs/weekly_report.md`  
URL: `https://github.com/davidahartmann/HippoTail/blob/main/docs/weekly_report.md`

## Agent context
github repo: `HippoTail/docs/agent_context.md`  
URL: `https://github.com/davidahartmann/HippoTail/blob/main/docs/agent_context.md`

## Project index
github repo: `HippoTail/docs/project_index.md`  
URL: `https://github.com/davidahartmann/HippoTail/blob/main/docs/project_index.md`

---

# Human-controlled files

Agents may read but must not modify these.

## Decisions log
github repo: `HippoTail/docs/DAVID_decisions_log.md`  
URL: `https://github.com/davidahartmann/HippoTail/blob/main/docs/DAVID_decisions_log.md`

## Meeting schedule
github repo: `HippoTail/docs/DAVID_meeting_schedule.md`  
URL: `https://github.com/davidahartmann/HippoTail/blob/main/docs/DAVID_meeting_schedule.md`

## Weekly agenda
github repo: `HippoTail/docs/DAVID_weekly_agenda.md`  
URL: `https://github.com/davidahartmann/HippoTail/blob/main/docs/DAVID_weekly_agenda.md`

---

# Contracts

Agents may not declare analysis complete unless contract acceptance criteria are satisfied.

## Replicate Lyu Fig 6C–6D
github repo: `HippoTail/contracts/CONTRACT_replicate6c6d.md`  
URL: `https://github.com/davidahartmann/HippoTail/blob/main/contracts/CONTRACT_replicate6c6d.md`

## HippoTail contrasts
github repo: `HippoTail/contracts/CONTRACT_HippoTail_contrasts.md`  
URL: `https://github.com/davidahartmann/HippoTail/blob/main/contracts/CONTRACT_HippoTail_contrasts.md`

---

# Repository folders

## Workflows
Purpose: notification and automation  
github repo: `HippoTail/.github/workflows`  
URL: `https://github.com/davidahartmann/HippoTail/tree/main/.github/workflows`

### hippo_notify workflow
github repo: `HippoTail/.github/workflows/hippo_notify.yml`  
URL: `https://github.com/davidahartmann/HippoTail/blob/main/.github/workflows/hippo_notify.yml`

## Code
Purpose: polished analysis code and reusable scripts  
github repo: `HippoTail/code`  
URL: `https://github.com/davidahartmann/HippoTail/tree/main/code`

### Lyu code
Purpose: publication code used for replication and adaptation  
github repo: `HippoTail/code/Lyu`  
URL: `https://github.com/davidahartmann/HippoTail/tree/main/code/Lyu`

## Docs
Purpose: operating procedures, plans, hypotheses, reports  
github repo: `HippoTail/docs`  
URL: `https://github.com/davidahartmann/HippoTail/tree/main/docs`

## Figures
Purpose: exported figures for PI review and manuscript development  
github repo: `HippoTail/figures`  
URL: `https://github.com/davidahartmann/HippoTail/tree/main/figures`

## Handoffs
Purpose: structured cloud-to-local and local-to-cloud execution handoffs between ChatGPT agents and local Codex/MATLAB
github repo: `HippoTail/handoffs`  
URL: `https://github.com/davidahartmann/HippoTail/tree/main/handoffs`

## Literature
Purpose: literature reports and ingestion outputs  
github repo: `HippoTail/lit`  
URL: `https://github.com/davidahartmann/HippoTail/tree/main/lit`

### Example literature report
github repo: `HippoTail/lit/weekly_litReport_1026.txt`  
URL: `https://github.com/davidahartmann/HippoTail/blob/main/lit/weekly_litReport_1026.txt`

## Logs
Purpose: reasoning logs, decision traces, and process notes  
github repo: `HippoTail/logs`  
URL: `https://github.com/davidahartmann/HippoTail/tree/main/logs`

## Results
Purpose: tables, statistical outputs, and narrative findings  
github repo: `HippoTail/results`  
URL: `https://github.com/davidahartmann/HippoTail/tree/main/results`

---

# Task-to-file map

## Startup / initialization
Read:
- `HippoTail/docs/HippoTail_OperatingSystem.md`
- `HippoTail/docs/HippoTail_ProjectBible.md`
- `HippoTail/docs/DAVID_weekly_agenda.md`
- `HippoTail/docs/Hypotheses.md`
- `HippoTail/docs/Experiment_Radar.md`
- `HippoTail/contracts/CONTRACT_replicate6c6d.md`
- `HippoTail/contracts/CONTRACT_HippoTail_contrasts.md`

## Hypothesis work
Read:
- `HippoTail/docs/Hypotheses.md`
- `HippoTail/docs/Literature_Map.md`
- `HippoTail/docs/Critic_Report.md`
- `HippoTail/docs/Experiment_Radar.md`

## Design work
Read:
- `HippoTail/docs/Study_Design.md`
- `HippoTail/docs/Hypotheses.md`
- `HippoTail/docs/Literature_Map.md`
- `HippoTail/docs/Critic_Report.md`

## Data work
Read:
- `HippoTail/docs/Data_Structure.md`
- `HippoTail/docs/Study_Design.md`
- `HippoTail/docs/Analysis_Plan.md`
- `HippoTail/handoffs`

## Analysis work
Read:
- `HippoTail/docs/Analysis_Plan.md`
- `HippoTail/docs/Data_Structure.md`
- `HippoTail/handoffs/EXECUTE_<analysis_name>.md`
- `HippoTail/handoffs/RETURN_<analysis_name>.md`
- relevant contract file(s)
- `HippoTail/code`
- `HippoTail/results`
- `HippoTail/figures`

---

# Failure fallback rule

If GitHub connector retrieval fails:

1. retry once with the exact repo path from this index
2. use the direct URL from this index
3. if `agent_context.md` or `project_index.md` is present in project sources, continue using those source copies
4. do not claim the file is unavailable until both repo path and direct URL have been attempted

---

# Notes for agents

- Prefer GitHub repo paths first because they preserve repository structure.
- Use URLs as backup, not as the first method.
- Keep retrieval narrow and task-specific.
- Use this file as the canonical navigation backup if GitHub access becomes unstable.
