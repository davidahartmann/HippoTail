# HippoTail — Analysis Plan

Maintained by: ResultsBoss  
Last updated: 2026-03-07

This document defines the analyses required to test HippoTail hypotheses.

---

# Analysis 1 — Tail Connectivity Map

Goal

Visualize connectivity strength from hippocampal tail to cortex and subcortex.

Output

Connectivity heatmap.

---

# Analysis 2 — Head vs Tail Contrast

Goal

Identify brain regions with stronger connectivity to tail vs head.

Output

Difference map. Subtract tail from head connectivity at electrodes that have both head and tail data (F1, aka R value), and plot the difference.

---

# Analysis 3 — Statistical Testing

Method

Mixed-effects models, follow very closely from Lyu, et al. Nature Neuroscience 2025.

Dependent variable

Connectivity strength (F1 statistic).

Predictors

hippocampal region (head vs tail)

distance

ROI

Random effect

patient ID

---

# Analysis 4 — Topographic Gradients

Goal

Test whether connectivity varies along anterior–posterior axis of middle temporal gyrus and thalamus.

Approach

Regression using anatomical coordinates. 

Visualization

For the middle temporal gyrus, flatten the superior-inferior axis, plot electrode contact locations using their MNI coordinate on a flattened brain at the location of the MTG.
Similar to the difference map above on the whole brain, subtract tail from head connectivity -- the intensity of the color will tell us head or tail preference.

---

# Analysis 5 — Contralateral Connectivity

Goal

Compare contralateral connections of tail vs head.

Output

Contralateral connectivity map. Shown on one brain hemisphere, but only the data that represents contralateral connections of head vs tail.
