# HippoTail — Data Structure

Maintained by: DataBoss  
Last updated: 2026-03-07

This document defines the structure of datasets used in the HippoTail project.

---

# Raw Data

Location

Google Drive

"Z:\My Drive\HippoTail_Data\data_processed" OR
"Z:\My Drive\HippoTail_Data\data_raw"

Files

"Z:\My Drive\HippoTail_Data\data_raw\metaTable.csv"
"Z:\My Drive\HippoTail_Data\data_raw\HBTonly_CCEP_166-251_hippocampus.csv"

Raw data must never be modified.

---

# Processed Data

Location

HippoTail_Data/data_processed/

Examples

connectivity_matrix.csv  
roi_mapping.csv  
distance_matrix.csv

---

# Key Variables

subject
sc1 (stimulating channel 1)
sc2 (stimulating channel 2)
rc1 (recording channel 1)
rc2 (recording channel 2)
JP_label_out (stimulating anatomic region)
JP_label_in (recording anatomic region)
Connectivity metric: peak_maxCor_clst1 (F1 statistic (R))
Latency (time_maxCor_clst1, in ms)
Euclidean distance (eudDist)
MNI coordinates of stimulated electrode contact (MNIout_coord_1, MNIout_coord_2, MNIout_coord_3)
MNI coordinates of recording electrode contact (MNIin_coord_1, MNIin_coord_2, MNIin_coord_3)
---

# Data Provenance

Every processed dataset must record:

source file  
analysis script  
date generated

# Data Locations

Canonical storage root

Z:\My Drive\HippoTail_Data

Raw data

Z:\My Drive\HippoTail_Data\data_raw

Processed data

Z:\My Drive\HippoTail_Data\data_processed

Figures

Z:\My Drive\HippoTail_Data\figures

Results

Z:\My Drive\HippoTail_Data\results

## Current primary input files

HBTonly_CCEP_166-251_hippocampus.csv
metaTable.csv

## Project-source copies for ChatGPT inspection

The following files may also be attached as Project sources for direct
inspection by agents in ChatGPT sessions:

- HBTonly_CCEP_166-251_hippocampus.csv
- metaTable.csv

Agents should treat the Project-source copies as readable working inputs for
schema inspection and planning, while treating the canonical Z:\ paths as the
source of record for the lab.

## Output policy

Processed tables should be written to:

Z:\My Drive\HippoTail_Data\data_processed

Final result tables should be written to:

Z:\My Drive\HippoTail_Data\results

Figures should be written to:

Z:\My Drive\HippoTail_Data\figures

Every processed output must record:

- source file(s)
- script used
- date generated
- analyst/agent responsible
