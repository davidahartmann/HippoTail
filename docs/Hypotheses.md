# HippoTail — Hypothesis Portfolio

Maintained by: ResearchScientist  
Last updated: 2026-03-08

Purpose

This document defines the current hypothesis portfolio for the HippoTail project.

The ResearchScientist maintains this file and ensures the project focuses on the
most promising scientific questions.

Maximum ACTIVE hypotheses: 5

Hypothesis status categories:

PROPOSED  
ACTIVE  
SUPPORTED  
REFUTED  
PARKED  
UNTESTABLE

Only ACTIVE hypotheses receive analysis priority.

---

# Active Hypotheses

| ID | Hypothesis | Status | Priority | Notes |
|----|------------|--------|----------|------|
| H1 | Hippocampal head connects preferentially to anterior limbic regions (amygdala, OFC, temporal pole), while hippocampal tail connects preferentially to posterior regions (posterior thalamus, posterior medial cortex). | ACTIVE | HIGH | Primary hypothesis |
| H2 | Hippocampal connectivity follows an anterior–posterior gradient across thalamus and temporal cortex. | ACTIVE | MED | Gradient hypothesis |
| H3 | Hippocampal tail exhibits stronger contralateral connectivity than hippocampal head. | ACTIVE | MED | Contralateral connectivity |
| H4 | Observed connectivity differences are explained by distance, electrode coverage bias, or accidental white matter stimulation. | ACTIVE | HIGH | Skeptic control hypothesis |

---

# Hypothesis Test Plans

This section defines the experiment required to evaluate each hypothesis.

---

## H1 — Posterior Network Hypothesis

Hypothesis

The hippocampal tail participates in a posterior brain network,
while the hippocampal head participates in an anterior limbic network.

Predictions

Tail connectivity stronger than head connectivity in:

posterior thalamus  
posterior medial cortex  

Head connectivity stronger than tail connectivity in:

amygdala  
orbitofrontal cortex  
temporal pole

Analysis

Mixed-effects model:

Connectivity ~ hippocampal_region + distance + ROI  
Random effect: patient

Visualization

Tail connectivity heatmap  
Head vs tail difference map

Status

AWAITING ANALYSIS

---

## H2 — Longitudinal Gradient Hypothesis

Hypothesis

Connectivity follows an anterior–posterior gradient across thalamus and temporal cortex.

Predictions

Anterior hippocampus → anterior temporal cortex  
Posterior hippocampus → posterior temporal cortex

Analysis

Regression of connectivity vs MNI coordinate.

Visualization

Flattened MTG connectivity gradient plot.

Status

NOT TESTED

---

## H3 — Contralateral Connectivity Hypothesis

Hypothesis

The hippocampal tail exhibits stronger contralateral connectivity than the hippocampal head.

Prediction

Tail → contralateral cortex connectivity > head.

Analysis

Contralateral connectivity heatmap.

Status

NOT TESTED

---

## H4 — Distance / Coverage Confound Hypothesis

Hypothesis

Observed connectivity differences are explained by geometric or sampling biases.

Potential mechanisms

distance attenuation  
electrode coverage bias  
white matter stimulation

Prediction

Connectivity differences disappear after controlling for:

Euclidean distance  
white matter proximity  
patient sampling

Analysis

Mixed-effects model including distance covariate.

Status

NOT TESTED

---

# Parked Hypotheses

| ID | Hypothesis | Reason Parked |
|----|------------|---------------|
| H5 | Hippocampal head signals travel via the fornix whereas tail signals travel via a different white matter tract. | Requires additional tract-specific analysis |

---

# Alternative Hypotheses

These hypotheses challenge the primary model and must be considered during analysis.

| ID | Hypothesis |
|----|------------|
| AH1 | Connectivity patterns are primarily determined by Euclidean distance between regions. |
| AH2 | Connectivity patterns are largely random across ROIs. |

---

# Evidence Ledger

This ledger records experimental or literature evidence relevant to hypotheses.

| Date | Evidence | Hypothesis Impact |
|-----|----------|------------------|
| YYYY-MM-DD | Lyu et al. replication successful | Supports H1 |
| YYYY-MM-DD | Distance correction removes tail advantage | Supports H4 |
| YYYY-MM-DD | Tail → PMC connectivity stronger | Supports H1 |

The ResearchScientist updates this ledger whenever new evidence appears.

---

# Recently Proposed Hypotheses

New ideas must be recorded here before being promoted to ACTIVE.

| ID | Hypothesis | Status |
|----|------------|-------|
| None yet | | |

---

# Hypothesis Revision Log

Date  
Hypothesis ID  
Change made  
Reason for change
