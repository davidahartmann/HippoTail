# HippoTail Project Index

START HERE if you are an AI agent or contributor entering the HippoTail repository.

This document provides the deterministic navigation map for the project.

---

# File Access Rule

When retrieving repository documents, follow this order:

1️⃣ Use GitHub repository path

Example

```
docs/HippoTail_OperatingSystem.md
```

2️⃣ If repository path access fails, use the raw GitHub URL

Example

```
https://raw.githubusercontent.com/davidahartmann/HippoTail/main/docs/HippoTail_OperatingSystem.md
```

3️⃣ If retrieval fails again, consult the README for backup navigation.

---

# Repository Layout

```
.github/
code/
contracts/
docs/
figures/
lit/
logs/
results/
```

---

# Core Project Documents

Agents entering the system should read the following files in order.

---

## 1. HippoTail Operating System

GitHub path

```
docs/HippoTail_OperatingSystem.md
```

Raw URL

```
https://raw.githubusercontent.com/davidahartmann/HippoTail/main/docs/HippoTail_OperatingSystem.md
```

Defines the rules of the HippoTail research operating system.

---

## 2. Project Bible

GitHub path

```
docs/HippoTail_ProjectBible.md
```

Raw URL

```
https://raw.githubusercontent.com/davidahartmann/HippoTail/main/docs/HippoTail_ProjectBible.md
```

Defines the scientific vision and long-term goals of the project.

---

## 3. Weekly Agenda

GitHub path

```
docs/DAVID_weekly_agenda.md
```

Raw URL

```
https://raw.githubusercontent.com/davidahartmann/HippoTail/main/docs/DAVID_weekly_agenda.md
```

Contains the current priorities set by the PI.

---

## 4. Hypotheses

GitHub path

```
docs/Hypotheses.md
```

Raw URL

```
https://raw.githubusercontent.com/davidahartmann/HippoTail/main/docs/Hypotheses.md
```

Active hypotheses under investigation.

---

## 5. Experiment Radar

GitHub path

```
docs/Experiment_Radar.md
```

Raw URL

```
https://raw.githubusercontent.com/davidahartmann/HippoTail/main/docs/Experiment_Radar.md
```

Tracks the current experiment portfolio.

---

# Contract System

Experiment contracts define when an analysis is considered complete.

Directory

```
contracts/
```

Examples

```
contracts/CONTRACT_replicate6c6d.md
contracts/CONTRACT_HippoTail_contrasts.md
```

---

# Code

Stable analysis code should be stored here.

```
code/
```

Example module

```
code/Lyu/
```

---

# Results

Analysis outputs and interpretations.

```
results/
```

---

# Figures

Generated visual outputs.

```
figures/
```

---

# Literature Intelligence

Automated literature reports.

```
lit/
```

---

# Logs

Optional reasoning logs.

```
logs/
```

---

# Workflow Summary

Typical workflow

1. PI updates weekly agenda
2. Agents review hypotheses and experiment radar
3. Agents initiate or complete contracts
4. Code is written in `/code`
5. Results generated in `/results`
6. Figures produced in `/figures`
7. Weekly reports summarize findings

```
```
