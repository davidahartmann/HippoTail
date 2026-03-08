# HippoTail Agent Context

This file is the master entry point for the HippoTail agent lab.

Agents must read this file before loading any other repository documents.
Read docs/agent_context.md and initialize the HippoTail agent lab.

Repository of record:
davidahartmann/HippoTail

Agents must access files through the GitHub connector using repository paths,
not full URLs.

Example:
fetch_file(repository_name="HippoTail", path="docs/Hypotheses.md", branch="main")

Agents must NOT assume files are loaded locally.

Agents must read only the files required for their task.

Repository Structure Rule:

docs/      = knowledge
lit/       = literature ingestion
contracts/ = definition of analysis completion
results/   = numerical outputs
figures/   = visual outputs
logs/      = persistent reasoning logs
code/      = scripts and notebooks

---

# Core Startup Procedure

Every agent must execute the following steps when starting:

1. Confirm repository access to:
   davidahartmann/HippoTail

2. Load the core startup files:

   docs/HippoTail_OperatingSystem.md
   docs/HippoTail_ProjectBible.md
   docs/DAVID_weekly_agenda.md

These define:

- project rules
- scientific scope
- current priorities

Agents must not propose scientific work until these files are read.

---

# Human-Controlled Files (Read Only)

The following files are edited only by the human PI.

Agents may read them but must never modify them.

docs/DAVID_weekly_agenda.md
docs/DAVID_meeting_schedule.md
docs/DAVID_decisions_log.md

These files define the current priorities and decisions.

---

# Agent-Owned Documents

Each agent owns exactly one primary document.

Agents may read other documents but must only modify their own.

ResearchScientist maintains:

docs/Hypotheses.md  
docs/Weekly_Report.md  
docs/PI_Briefing.md  
docs/Research_Log.md

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

# Literature Ingestion

Weekly literature reports are stored in:

lit/

File naming convention:

weekly_litReport_YYYYMMDD.txt  
weekly_litReport_YYYYMMDD.md

LitBoss workflow:

1. Search the repository for the newest literature report:

   search(query="weekly_litReport", repository_name="HippoTail")

2. Fetch the most recent file from the lit/ directory.

3. Extract key findings.

4. Update:

   docs/Literature_Map.md

5. Add literature findings and recommended next queries to:

   docs/Weekly_Report.md

---

# Contracts

Analysis completion is defined by files in:

contracts/

Agents may not declare an analysis complete unless the relevant contract is satisfied.

---

# Context Discipline

Agents must load only the files required for their task.

Research tasks may read:

docs/HippoTail_OperatingSystem.md  
docs/HippoTail_ProjectBible.md  
docs/DAVID_weekly_agenda.md  
docs/Hypotheses.md  
docs/Literature_Map.md  
docs/Critic_Report.md  

Design tasks may read:

docs/Study_Design.md  
docs/Hypotheses.md  
docs/Literature_Map.md  
docs/Critic_Report.md  

Data tasks may read:

docs/Data_Structure.md  
docs/Study_Design.md  
docs/Analysis_Plan.md  

Analysis tasks may read:

docs/Analysis_Plan.md  
docs/Data_Structure.md  
contracts/  
results/  
figures/  

Do not load unrelated files.

---

# Mission

The mission of the HippoTail agent lab is to:

- discover meaningful hippocampal tail connectivity patterns using CCEP data
- generate reproducible analyses
- refine hypotheses iteratively
- produce publishable neuroscience
