# HippoTail Data Structure

Maintained by: DataBoss

This document describes the datasets used by the HippoTail project and their provenance.

---

# 1. Primary datasets

The primary datasets used for analysis are provided as **ChatGPT Project Sources**.

These files are accessible to agents within the ChatGPT project environment.

Primary datasets:

HBTonly_CCEP_166-251_hippocampus.csv  
metaTable.csv

These files should be treated as the canonical working datasets for analysis.

---

# 2. Canonical data storage

The human PI maintains the full dataset archive in Google Drive.

Root location:

Z:\My Drive\HippoTail_Data

Subfolders:

data_raw  
data_processed  
figures  
results

---

# 3. Raw data

Raw datasets are stored in:

Z:\My Drive\HippoTail_Data\data_raw

Example raw dataset:

HBTonly_CCEP_166-251_hippocampus.csv

This file contains hippocampal CCEP responses for electrodes spanning hippocampal head, body, and tail.

---

# 4. Metadata tables

Metadata describing electrodes and patients are stored in:

metaTable.csv

This file contains:

- patient identifiers
- electrode locations
- ROI assignments
- stimulation site metadata

---

# 5. Processed data

Derived datasets generated during analysis should be stored in:

Z:\My Drive\HippoTail_Data\data_processed

Examples:

contrast matrices  
ROI connectivity tables  
UMAP-filtered datasets

---

# 6. Figures

Generated figures should be saved to:

Z:\My Drive\HippoTail_Data\figures

Examples:

contrast heatmaps  
brain connectivity maps  
replicated figures from Lyu et al.

---

# 7. Results tables

Statistical outputs should be saved to:

Z:\My Drive\HippoTail_Data\results

Examples:

contrast_statistics.csv  
replicated_tableS2.csv  
replicated_tableS3.csv

---

# 8. Data provenance requirements

All derived outputs must record:

- source dataset
- filtering rules
- analysis script used
- date generated
- responsible agent

This ensures reproducibility.

---

# 9. Current project datasets

Active datasets:

HBTonly_CCEP_166-251_hippocampus.csv  
metaTable.csv

These datasets are used for:

- hippocampal connectivity contrast analyses
- head vs body vs tail comparisons
- replication of Lyu et al. Fig 6C–6D
