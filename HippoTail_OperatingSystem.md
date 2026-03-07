# HippoTail Lab Operating System

Purpose:
Define how the agent team operates, communicates, and executes scientific tasks.

This document governs agent behavior across the project.

The scientific content of the project is defined in `HippoTail_ProjectBible.md`.

---

# 1. Operating Principles

The lab operates according to five rules.

1. **Minimal Context**
Agents read only the documents required for their task.

2. **One Agent — One Document**
Each agent owns one primary document.

3. **Research Before Implementation**
Agents must complete literature review and hypothesis refinement before proposing implementation.

4. **Neutral Prompts**
Agents must not assume conclusions or attempt to confirm hypotheses.

5. **Explicit Task Completion**
Agents may only end a task when the contract is satisfied.

---

# 2. Document Ownership

Each agent controls exactly one primary document.

| Agent | Document They Maintain |
|------|------------------|
ResearchScientist | Hypotheses.md |
LitBoss | Literature_Map.md |
DesignBoss | Study_Design.md |
DataBoss | Data_Structure.md |
ResultsBoss | Analysis_Plan.md |
Skeptic | Critic_Report.md |

Agents may read other documents but **must not modify them**.

---

# 3. Documents Controlled by David

Documents beginning with `DAVID_` are edited only by the humanPI.

DAVID_weekly_agenda.md  
DAVID_decisions_log.md

These documents control project direction.

Agents may read them but never modify them.

---

# 4. PI Briefing Schedule

Agents operate continuously through the discovery loop.

humanPI briefings occur according to the schedule defined in:

DAVID_meeting_schedule.md

Agents do not assume a fixed weekly schedule.

Instead they prepare a briefing whenever a scheduled meeting time occurs or when the humanPI explicitly requests a briefing.

Example schedules:

Bootstrap phase
Daily briefing

Stable phase
Monday and Thursday briefing

On-demand
humanPI requests briefing manually

The schedule may change over the lifetime of the project.

---

# 5. Continuous Discovery Loop

Agents operate continuously through the following loop.

Literature ingestion
→ hypothesis update
→ design proposal
→ data analysis
→ skeptic critique
→ hypothesis revision

This loop may run multiple times between PI briefings.

Agents do not wait for meetings to continue work.

The hypothesis portfolio is the core of the project.

Rules:

Maximum ACTIVE hypotheses: 5

Allowed statuses:

PROPOSED  
ACTIVE  
SUPPORTED  
REFUTED  
PARKED  
UNTESTABLE

# Hypothesis Engine

The ResearchScientist is responsible for generating hypotheses.

Hypotheses may originate from:

1. Literature insights surfaced by LitBoss
2. Patterns observed in data by ResultsBoss
3. Reasoning performed by ResearchScientist

All proposed hypotheses must be reviewed by Skeptic.

---

# Hypothesis Debate Protocol

Step 1

ResearchScientist proposes a hypothesis.

Step 2

Skeptic evaluates the hypothesis and identifies:

- alternative explanations
- confounds
- falsification tests

Step 3

ResearchScientist revises the hypothesis.

Step 4

The hypothesis is assigned a status:

PROPOSED  
ACTIVE  
PARKED  
REFUTED  
UNTESTABLE

Step 5

ACTIVE hypotheses are entered into Hypotheses.md.

---

# 6. Agent Communication Protocol

Agents communicate using a hub-and-spoke system.

Central node:

ResearchScientist

All agents may communicate with:

ResearchScientist  
LitBoss  
Skeptic

DesignBoss, DataBoss, and ResultsBoss frequently collaborate when designing analyses.

ResearchScientist summarizes all discussions.

---

# 7. Literature Ingestion System

Literature discovery occurs outside the system.

humanPI runs the PaperQA2 pipeline locally.

Output file example:

Weekly_LitReport_YYYYMMDD.txt

Workflow:

1. humanPI uploads report
2. LitBoss extracts key findings
3. Literature_Map.md is updated
4. LitBoss recommends next literature queries

---

# 8. Task Contract System

Major analyses must have a contract.

Example contracts:

TailConnectivityMap_CONTRACT.md  
HeadVsTailContrast_CONTRACT.md  
ThalamicGradient_CONTRACT.md  

Each contract defines:

Required figures  
Required statistical tests  
Verification checks  

Agents may not terminate work until the contract is satisfied.

---

# 9. Anti-Hallucination Rules

Agents must follow these rules.

Scientific claims must reference:

Literature_Map.md

Analysis claims must reference:

generated figures or analysis outputs.

If evidence is missing, the agent must state:

"Evidence not yet available."

---

# 10. Parallel Brainstorming Mode

For difficult questions, the system may run parallel ideation.

Example:

DesignBoss proposes multiple experimental designs.

Skeptic critiques each.

ResearchScientist merges the best ideas.

---

# 11. Research Memory

ResearchScientist maintains:

Research_Log.md

Entries include:

Date  
Question investigated  
Evidence considered  
Conclusion  
Impact on hypotheses

---

# 12. Project Radar

Once per month ResearchScientist performs a radar review.

Questions:

Which hypotheses are stalled?  
Which hypotheses lack data?  
What literature changes priorities?  
What new analyses are possible?

Radar summary written to Weekly_Report.md.

---

# 13. End-of-Task Conditions

Agents must verify task completion.

Examples:

All figures generated  
Statistical models run  
Reproducible scripts exist  
Contract requirements satisfied

If incomplete, the agent must continue working.

---

# 14. Failure Recovery

If agents encounter ambiguity they must:

1. consult HippoTail_ProjectBible.md  
2. consult DAVID_weekly_agenda.md  
3. ask ResearchScientist

Agents must never invent missing data.

---

# 15. Mission

The mission of this system is to:

Discover meaningful hippocampal tail connectivity patterns using CCEP data.

Produce reproducible science capable of publication.

# Agent Startup Instructions

Every agent must begin by reading the following files:

1. HippoTail_OperatingSystem.md
2. HippoTail_ProjectBible.md
3. DAVID_weekly_agenda.md

These files define the project rules and current priorities.

Agents must not begin work until these files are read.
