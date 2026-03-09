# HippoTail — Study Design

Maintained by: DesignBoss  
Last updated: 2026-03-07

This document defines the experimental and analytical design used to test HippoTail hypotheses.

---

# Data Sources

Primary datasets are attached to the HippoTail ChatGPT Project as Project Sources.

These files are available to agents through the ChatGPT environment and are not stored in the GitHub repository.

Primary datasets:

HBTonly_CCEP_166-251_hippocampus.csv  
metaTable.csv

Agents should treat these files as the canonical working datasets.

---

# Electrode Classification

Electrode contacts classified as:

HEAD  
BODY  
TAIL  

Classification derived from anatomical definitions already present in dataset.

---

# Regions of Interest

Primary ROIs (name in spreadsheet)

amygdala (AMY)
orbitofrontal cortex  (OFC)
temporal pole  (TP)
middle temporal gyrus (MTG)  
fusiform gyrus  (FG)
cingulate cortex  (ACC and MCC, should rename all to CING)
anterior thalamus  (antTH)
posterior thalamus  (pstTH)
posterior medial cortex  (PMC)

---

# Experimental Comparisons

Primary comparison

Head vs tail connectivity

Secondary comparisons

In thalamus and MTG, compare topography of HEAD, BODY, TAIL connections.

Ipsilateral vs contralateral connections of head vs tail

---

# Key Measurements

Connectivity strength

CCEP F1 statistic (R) (column peak_maxCor_clst1 in spreadsheets)

Latency 

Evoked response timing (time_maxCor_clst1 in spreadsheets)

---

# Statistical Framework

Mixed-effects models (lme4)

Patient treated as random effect.

Multiple comparisons corrected across ROIs.

---

# Known Design Risks

Sparse tail electrode coverage  
distance-dependent signal attenuation  
white matter stimulation confounds
