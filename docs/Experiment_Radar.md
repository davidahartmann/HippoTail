# HippoTail — Experiment Radar

Maintained by: ResearchScientist  
Last updated: YYYY-MM-DD

Purpose

The Experiment Radar identifies the most important experiments or analyses
needed to advance the HippoTail project.

This document ensures the project continues to move forward and does not stall
on a single analysis.

The ResearchScientist updates this document weekly.

---

# Radar Categories

Each item must be classified into one of the following categories:

BLOCKER  
HIGH VALUE  
LOW COST  
DATA GAP  
HYPOTHESIS TEST

---

# Current Radar

## BLOCKERS

### Replication of Lyu et al. (Nature Neuroscience 2025)

Goal

Verify that the analysis pipeline reproduces:

Figure 6C  
Figure 6D  
Table S2  
Table S3

Reason

All HippoTail analyses depend on confirming the original methodology.

Owner

ResultsBoss

Status

NOT STARTED

---

## HIGH VALUE EXPERIMENTS

### Tail Connectivity Map

Goal

Generate first hippocampal tail → brain connectivity heatmap.

Importance

Establish baseline visualization of connectivity patterns.

Owner

ResultsBoss

---

### Head vs Tail Difference Map

Goal

Identify regions preferentially connected to hippocampal tail.

Output

Glass brain difference map.

Owner

ResultsBoss

---

## LOW COST ANALYSES

### ROI Coverage Report

Goal

Quantify number of patients and contacts per ROI.

Purpose

Determine which ROIs are statistically viable.

Owner

DataBoss

---

### Distance Distribution Analysis

Goal

Compare Euclidean distance distributions between head and tail contacts.

Purpose

Evaluate whether distance explains connectivity differences.

Owner

DataBoss

---

## DATA GAPS

### Tail Electrode Coverage

Concern

Tail electrodes are sparse in dataset.

Action

Quantify coverage across patients and ROIs.

Owner

DataBoss

---

### White Matter Contact Annotation

Concern

Tail contacts may lie near white matter tracts.

Action

Add WM proximity annotation column to dataset.

Owner

DataBoss

---

## HYPOTHESIS TESTS

### H1 — Posterior Network Hypothesis

Test

Tail connectivity stronger in:

posterior thalamus  
posterior medial cortex

Method

Mixed-effects models controlling for distance.

Owner

ResultsBoss

---

### H3 — Contralateral Connectivity

Test

Tail exhibits stronger contralateral connectivity than head.

Method

Contralateral connectivity heatmap.

Owner

ResultsBoss

---

# Radar Review Protocol

ResearchScientist must review this radar:

Weekly  
or when a new dataset or literature report appears.

During review the ResearchScientist must:

1. Identify stalled experiments
2. Promote high-value analyses
3. Add newly discovered opportunities
4. Remove completed items

---

# Radar Summary for PI

When generating the weekly briefing, summarize:

Most important radar item  
Biggest blocker  
Next experiment recommended
