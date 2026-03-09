# HippoTail

HippoTail is a structured research repository designed to function as a research operating system for the HippoTail project.

It organizes hypotheses, experimental contracts, code, results, handoffs, and literature in a deterministic structure so that both humans and AI agents can navigate and contribute reliably.

---

## Repository Navigation

Primary entry point for agents and contributors:

### GitHub path

docs/project_index.md

### Raw URL

https://raw.githubusercontent.com/davidahartmann/HippoTail/main/docs/project_index.md

This file explains the structure of the repository and where each type of artifact should live.

---

## File Access Rule for Agents and Tools

When retrieving any file in this repository, use the following order:

### 1. Try GitHub path first

Example:

docs/HippoTail_OperatingSystem.md

### 2. If path access fails, use the raw GitHub URL

Example:

https://raw.githubusercontent.com/davidahartmann/HippoTail/main/docs/HippoTail_OperatingSystem.md

### 3. If retrieval still fails, consult this README

The README contains navigation links for major project documents and folders.

---

## Core Project Documents

### HippoTail Operating System

GitHub path  
docs/HippoTail_OperatingSystem.md

Raw URL  
https://raw.githubusercontent.com/davidahartmann/HippoTail/main/docs/HippoTail_OperatingSystem.md

---

### Project Bible

GitHub path  
docs/HippoTail_ProjectBible.md

Raw URL  
https://raw.githubusercontent.com/davidahartmann/HippoTail/main/docs/HippoTail_ProjectBible.md

---

### Hypotheses

GitHub path  
docs/Hypotheses.md

Raw URL  
https://raw.githubusercontent.com/davidahartmann/HippoTail/main/docs/Hypotheses.md

---

### Experiment Radar

GitHub path  
docs/Experiment_Radar.md

Raw URL  
https://raw.githubusercontent.com/davidahartmann/HippoTail/main/docs/Experiment_Radar.md

---

### Analysis Plan

GitHub path  
docs/Analysis_Plan.md

Raw URL  
https://raw.githubusercontent.com/davidahartmann/HippoTail/main/docs/Analysis_Plan.md

---

### Study Design

GitHub path  
docs/Study_Design.md

Raw URL  
https://raw.githubusercontent.com/davidahartmann/HippoTail/main/docs/Study_Design.md

---

### Data Structure

GitHub path  
docs/Data_Structure.md

Raw URL  
https://raw.githubusercontent.com/davidahartmann/HippoTail/main/docs/Data_Structure.md

---

## PI Control Documents

### Weekly Agenda

GitHub path  
docs/DAVID_weekly_agenda.md

Raw URL  
https://raw.githubusercontent.com/davidahartmann/HippoTail/main/docs/DAVID_weekly_agenda.md

---

### Decision Log

GitHub path  
docs/DAVID_decisions_log.md

Raw URL  
https://raw.githubusercontent.com/davidahartmann/HippoTail/main/docs/DAVID_decisions_log.md

---

### Meeting Schedule

GitHub path  
docs/DAVID_meeting_schedule.md

Raw URL  
https://raw.githubusercontent.com/davidahartmann/HippoTail/main/docs/DAVID_meeting_schedule.md

---

## Repository Structure

.github/        automation and workflow notifications  
code/           analysis code developed by agents and researchers  
contracts/      experiment completion contracts  
docs/           project brain and operating procedures  
figures/        visual outputs for review  
handoffs/       structured cloud-to-local and local-to-cloud execution handoffs  
lit/            literature intelligence reports  
logs/           reasoning or execution logs  
results/        analysis outputs and statistical summaries  

---

## Code

Stable analysis code should be stored in:

code/

Repository URL  
https://github.com/davidahartmann/HippoTail/tree/main/code

Example module containing previously published useful code that this project may build on:

code/Lyu/

Agents and contributors should place stable reusable analysis code here.

---

## Contracts

Contracts define when a piece of analysis is considered complete.

Examples:

contracts/CONTRACT_replicate6c6d.md  
contracts/CONTRACT_HippoTail_contrasts.md  

Example URLs

https://github.com/davidahartmann/HippoTail/blob/main/contracts/CONTRACT_replicate6c6d.md  
https://github.com/davidahartmann/HippoTail/blob/main/contracts/CONTRACT_HippoTail_contrasts.md  

---

## Results

Statistical outputs, tables, and interpretations of completed experiments.

results/

https://github.com/davidahartmann/HippoTail/tree/main/results

---

## Figures

Visual outputs generated during analysis.

figures/

https://github.com/davidahartmann/HippoTail/tree/main/figures

---

## Handoffs

Structured communication between cloud agents and local Codex execution.

This folder is the main bridge between:

- ChatGPT cloud agents
- local Codex execution
- desktop MATLAB outputs

Typical files include:

EXECUTE_<analysis_name>.md  
RETURN_<analysis_name>.md  
run_manifest_<analysis_name>.json  
outputs_manifest_<analysis_name>.csv  

GitHub path

handoffs/

Repository URL

https://github.com/davidahartmann/HippoTail/tree/main/handoffs

---

## Literature

Automated literature reports and literature intelligence outputs.

Example:

lit/weekly_litReport_1026.txt

Example URL

https://github.com/davidahartmann/HippoTail/blob/main/lit/weekly_litReport_1026.txt

---

## Logs

Optional reasoning logs from agents and researchers.

logs/

https://github.com/davidahartmann/HippoTail/tree/main/logs

---

## Working Principle

HippoTail is designed as a hybrid cloud-local lab:

- cloud agents read docs, reason about study design, propose analyses, and generate code
- local Codex and desktop MATLAB execute analyses against the PI's actual file system and tools
- GitHub stores the durable project memory, codebase, contracts, and handoff records

When a task requires local execution, agents should use the operating system and the `handoffs/` folder to communicate clearly and reproducibly.

---

## Primary Rule for Agents

Agents should begin with:

1. docs/project_index.md  
2. docs/HippoTail_OperatingSystem.md  
3. other task-relevant files only  

Agents should not load the entire repository unless explicitly instructed to do so.
