HippoTail — Project Bible

Project: Hippocampal tail connectivity using cortico-cortico evoked potentials (CCEP/SPES)
Owner (humanPI): David
AI Project Lead: ResearchScientist
Last updated: 2026-03-05
Current phase: Discovery

0) Project Goal

Determine the afferent and efferent connectivity of the hippocampal tail using human CCEP/SPES recordings and compare it to the hippocampal head/body.

Primary objective:

Identify network differences between anterior and posterior hippocampus and evaluate their relevance for epilepsy surgery and neuromodulation.

0.5 Agent Context Rules

Agents must only read documents required for their task.

Loading unnecessary context degrades reasoning.

Allowed context per task:

Research tasks

Project_Bible.md

Literature_Map.md

Hypotheses.md

Design tasks

Hypotheses.md

Literature_Map.md

Study_Design.md

Data tasks

Study_Design.md

Data_Structure.md

Analysis tasks

Data_Structure.md

Analysis_Plan.md

Agents must not load the entire project unless explicitly instructed.

1) Why This Project Matters
Clinical Significance

Key clinical motivations:

Seizures can originate in the posterior hippocampus, yet most surgeries target the anterior hippocampus.

Approximately 30% of patients remain epileptic after temporal lobectomy.

Tail involvement may explain surgical failure and influence neuromodulation targeting (DBS, RNS).

The hippocampal tail can be surgically treated (resection or LITT), but functional consequences and connectivity remain poorly understood.

Field Significance

Current knowledge gap:

The hippocampal tail is rarely sampled in SEEG datasets.

Most studies focus on the anterior hippocampus.

fMRI and tractography suggest longitudinal hippocampal gradients, but causal connectivity has not been tested with CCEPs.

This project aims to establish a causal connectivity map.

Field-Impact Result

A high-impact finding would demonstrate that:

Anterior hippocampus and posterior hippocampus participate in distinct brain networks.

Implications:

interpretation of fMRI and tractography

neuromodulation targeting

surgical planning in epilepsy

2) Scope Boundaries
In Scope (v1)

CCEP effective connectivity maps from hippocampal head vs tail

ROI-based comparisons including

amygdala
orbitofrontal cortex
temporal pole
cingulate
anterior thalamus
posterior thalamus
medial parietal cortex

latency-based inference of white-matter pathways

reproducible analysis pipeline

Out of Scope (v1)

The project will not include:

epilepsy mechanism studies

new signal processing methods

animal experiments

MRI-only analyses

hippocampal subfield biology

3) Definition of Done (v1)

The project is complete when the following results exist:

1. Hippocampal Connectivity Map

Heatmap of tail connectivity across cortex and subcortex.

Metric:

CCEP F1 statistic (R) from Lyu et al., Nature Neuroscience 2025.

2. Head vs Tail Contrast Map

Connectivity difference map:

tail – head

Displayed on glass brain heatmap.

3. Statistical Testing

Mixed-effects modeling (R lme4):

nested patient structure

multiple comparisons

Primary ROIs:

OFC
amygdala
temporal pole
middle temporal gyrus
fusiform
cingulate
anterior thalamus
posterior thalamus
posterior medial cortex

4. Distance Correction

Connectivity models controlling for

Euclidean distance in MNI space.

5. White Matter Control

Test if simple proximity to major white matter tracts explains the results, such as:

fornix

inferior longitudinal fasciculus

tapetum

6. Topographic Connectivity Gradients

Test whether

anterior hippocampus → anterior middle temporal gyrus, anterior thalamus
posterior hippocampus → posterior middle temporal gyrus, posterior thalamus

Approach:

coordinate-based connectivity models.

7. Contralateral Connectivity

Tail contralateral connections compared to head.

4) Operational Definitions
Hippocampal Tail

Contacts labeled HEAD / BODY / TAIL using anatomical criteria already present in dataset.

Definition derived from hippocampal segmentation consensus.

CCEP Connection Definition

Primary metrics:

F1 statistic (R)

latency

Artifact handling:

analysis repeated with

UMAPact = 1
UMAPact = 0

5) Hypothesis Portfolio

Maximum 5 ACTIVE hypotheses.

Additional hypotheses may be:

PARKED
REFUTED
UNTESTABLE

Hypothesis Dashboard
ID	Hypothesis	Status	Priority
H1	Head connects to limbic/anterior networks, tail connects to posterior networks	ACTIVE	HIGH
H2	Hippocampal connectivity follows anterior-posterior gradient	ACTIVE	MED
H3	Tail has stronger contralateral connectivity	ACTIVE	MED
H4	Connectivity differences explained by distance/coverage	ACTIVE	HIGH
H5	Thalamic nuclei selectively connect to head vs tail	PARKED	MED
Alternative Hypotheses

Explicit alternatives prevent confirmation bias.

AH1

Connectivity explained by geographic distance.

AH2

Connectivity is largely random.

6) Iterative Discovery Loop

Project workflow:

Literature
→ Hypothesis portfolio
→ Design
→ Data analysis
→ Hypothesis revision

6.1 Research Log

Maintained by ResearchScientist.

File:

Research_Log.md

Purpose:

Record how evidence updates hypotheses.

Entry format:

Date
Question
Evidence
Conclusion
Impact on hypotheses

7) Agent Team
humanPI

Controls strategy via:

DAVID_weekly_agenda.md

ResearchScientist

Project lead.

ResearchScientist responsibilities

1. Maintain the hypothesis portfolio
2. Generate new hypotheses based on literature and data
3. Debate hypotheses with Skeptic
4. Select which hypotheses should be ACTIVE
5. Coordinate DesignBoss, DataBoss, and ResultsBoss
6. Produce Weekly_Report.md and PI_Briefing.md

LitBoss

Curates literature.

Owns:

Literature_Map.md

Outputs to:

Weekly_Report.md

Skeptic

Skeptic responsibilities

1. Critique hypotheses proposed by ResearchScientist
2. Identify confounds and alternative explanations
3. Propose falsification tests
4. Flag weak reasoning or unsupported assumptions
5. Write Critic_Report.md

DesignBoss

Converts hypotheses into experimental designs.

Owns:

Study_Design.md

DataBoss

Defines data structures and provenance.

Owns:

Data_Structure.md

ResultsBoss

Produces analysis plan and figures.

Owns:

Analysis_Plan.md

8) Agent Communication Protocol

Hub-and-spoke model.

All agents interact with:

ResearchScientist
LitBoss
Skeptic

ResearchScientist produces the weekly synthesis.

9) Project Documents

Minimal document set.

Agents should only modify their assigned file.

Project documents:

Project_Bible.md

DAVID_weekly_agenda.md

DAVID_decisions_log.md

Literature_Map.md

Hypotheses.md

Study_Design.md

Data_Structure.md

Analysis_Plan.md

Weekly_Report.md

Critic_Report.md

10) Literature Pipeline

Literature search is executed locally by David.

Pipeline:

PaperQA2 PowerShell script.

Output:

Weekly_LitReport_YYYYMMDD.txt

Process:

David runs literature search locally

Report uploaded to project

LitBoss updates Literature_Map.md

Summary written into Weekly_Report.md

11) Anti-Bias Rule

Agents must avoid confirmation prompts.

Incorrect prompt

“Find evidence supporting hypothesis X.”

Correct prompt

“Review literature related to X and summarize findings.”

12) Known Confounds

Electrode coverage bias
distance effects
artifact blanking
sleep/medication state

These must be explicitly tested.

13) Project Radar

Activated April 2026.

ResearchScientist monitors:

stalled hypotheses

missing data

new literature

opportunities for new analyses

Summary written in Weekly_Report.md.

14) One Agent — One Document Rule

Each agent owns one document.

ResearchScientist → Hypotheses.md
LitBoss → Literature_Map.md
DesignBoss → Study_Design.md
DataBoss → Data_Structure.md
ResultsBoss → Analysis_Plan.md
Skeptic → Critic_Report.md

15) Decisions Required from David Each Week

Only four decisions are required:

Which hypotheses are ACTIVE?

Which hypothesis receives the next push?

What minimal dataset is required?

What confound must be neutralized next?

These decisions are recorded in:

DAVID_decisions_log.md