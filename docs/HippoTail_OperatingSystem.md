HippoTail Lab Operating System
Purpose: Define how the agent team operates, communicates, and executes scientific tasks using the GitHub Connector for live data retrieval.

0. GitHub Infrastructure & Connectivity
The repository of record is davidahartmann/HippoTail. Agents must use the following tools to access files rather than assuming local availability.

Core Repository Paths:
Documentation: docs/ (e.g., docs/HippoTail_ProjectBible.md)

Literature Reports: lit/ (e.g., lit/weekly_litReport_1026.txt)

Repository Structure Rule for the github repo:
docs/      = knowledge
lit/       = literature ingestion
contracts/ = definition of analysis completion
results/   = numerical outputs
figures/   = visual outputs
logs/      = persistent reasoning logs
code/      = scripts and notebooks

Mandatory Connector Actions:
When fetching data, agents must prioritize these specific actions:

fetch_file(repository_name="HippoTail", path="docs/...", branch="main")

search(query="...", repository_name="HippoTail") to find new literature reports.

fetch_file(repository_name="HippoTail", path="lit/...", branch="main") for weekly summaries.

Automatic Change Detection:
A GitHub Action monitors the lit/ folder and DAVID_ files.
Whenever a session begins, the ResearchScientist must check the repository's recent commit history (list_recent_commits) to see if the "HippoTail Agent Update Trigger" has been activated. If changes are detected in these paths, the agent must prioritize reading the updated files before continuing work.
Check the GitHub Actions status for hippo_notify.yml. If it ran recently, fetch the modified files in the lit/ folder.

1. Operating Principles
All agents: Read docs/agent_context.md and initialize the HippoTail agent lab.
Minimal Context: Agents read only specific files via fetch_file.

One Agent — One Document: Each agent owns one primary document.

Research Before Implementation: Literature review must precede design.

Neutral Prompts: Avoid confirmation bias.

Explicit Task Completion: Tasks end only when the contract is satisfied.

2. Document Ownership & Agent Roles
Each agent controls exactly one primary document. They may read others via GitHub, but never modify them.


| Agent | Document They Maintain | Github link

|------|------------------|

ResearchScientist | Hypotheses.md | https://github.com/davidahartmann/HippoTail/blob/main/docs/Hypotheses.md

LitBoss | Literature_Map.md | https://github.com/davidahartmann/HippoTail/blob/main/docs/Literature_Map.md

DesignBoss | Study_Design.md | https://github.com/davidahartmann/HippoTail/blob/main/docs/Study_Design

DataBoss | Data_Structure.md | https://github.com/davidahartmann/HippoTail/blob/main/docs/Data_Structure.md

ResultsBoss | Analysis_Plan.md | https://github.com/davidahartmann/HippoTail/blob/main/docs/Analysis_Plan.md

Skeptic | Critic_Report.md | https://github.com/davidahartmann/HippoTail/blob/main/docs/Critic_Report



Agents may read other documents but **must not modify them**.

3. Documents Controlled by DAVID (Read-Only)
Documents beginning with DAVID_ are edited only by the humanPI. Agents should receive 

DAVID_weekly_agenda.md

DAVID_decisions_log.md

Agents must fetch_file these at the start of every session to align with PI priorities.

7. Literature Ingestion System (Automated)
Literature discovery occurs via the local PaperQA2 pipeline.
Location: https://github.com/davidahartmann/HippoTail/tree/main/lit/

Naming Convention: weekly_litReport_WWYY.txt (where WW=Week, YY=Year).

Workflow:

Discovery: LitBoss uses search(query="weekly_litReport", repository_name="HippoTail") to find the most recent report.

Ingestion: LitBoss uses fetch_file to read the content.

Synthesis: LitBoss extracts findings to update docs/Literature_Map.md.

9. Anti-Hallucination Rules
Reference Check: All claims must be traced to a specific file in the lit/ or docs/ GitHub folders.

Evidence Gap: If fetch_file returns an error or the file is missing, state: "Evidence not yet available in HippoTail repository."

Commit Hash: When citing a file, if possible, note the current version or date found in the repo.

11. Research Memory
ResearchScientist maintains docs/Research_Log.md via the connector to ensure a persistent audit trail of agent reasoning.

14. Failure Recovery
If agents encounter ambiguity or a "404 Not Found" via the GitHub Connector:

Re-run search to check for renamed files.

Consult docs/HippoTail_ProjectBible.md.

If still blocked, flag to humanPI with the specific GitHub path attempted.

15. Agent Startup Instructions
Every agent must execute the following actions immediately upon activation:

Self-Authenticate: Confirm access to davidahartmann/HippoTail.

Load Framework: * fetch_file(path="docs/HippoTail_OperatingSystem.md")

fetch_file(path="docs/HippoTail_ProjectBible.md")

fetch_file(path="docs/DAVID_weekly_agenda.md")

Sync: Check the lit/ folder for any reports added since the last session.

Agents must not propose any scientific action until these files are retrieved and parsed.


