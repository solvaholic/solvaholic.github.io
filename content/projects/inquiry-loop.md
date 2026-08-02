---
title: "Inquiry Loop"
date: 2026-06-03T19:54:26-04:00
summary: "An experimental diverge-graph-converge engine for research and sensemaking - currently a deliberately low-tech prototype run by hand, one markdown note at a time."
tags: ["research", "sensemaking", "prototyping", "llm", "critical-thinking"]
weight: 5
---

[inquiry-loop](https://github.com/solvaholic/inquiry-loop) is an experimental inquiry engine: a diverge-graph-converge loop for research and sensemaking. Most AI research tools try to give you an answer; this one helps you map the questions. Instead of treating statements as simple true/false propositions, it tracks how they function in context - as claims to test, evidence to weigh, or assumptions to challenge. It's a branching, automated "Five Whys" meant to augment human critical thinking rather than bypass it.

## Current state: manual prototype

There's no engine yet, and that's on purpose. The repo is a deliberately low-tech prototype: each run is a single markdown note in [`runs/`](https://github.com/solvaholic/inquiry-loop/tree/main/runs), driven by an operator working with an LLM in conversation. The point is to watch how the loop *actually behaves* on real seeds before designing any schema or code around it.

What's here:
- **`runs/`**: Completed runs, one per markdown file, covering the full loop from seed and pre-flight to diverge, answer pass, and converge.
- **`runs/_template.md`**: Skeleton for new runs, prompting for seeds, intents, and categories.
- **`notes/engine-notes.md`**: Sourced from completed runs, tracking what we believe about how the loop should behave with beliefs tagged by confidence level.
- **`notes/seed-patterns.md`**: Operational suggestions detailing which seed and intent combinations have worked, what they produce, and what they tend to open.

The current rule: **resist formalizing until the prose breaks.**

## How a run works

1. **Seed** - Statement + initial role (Claim / Evidence / Assumption / Question) + engine-task intent (what should the run *do*?) + downstream purpose (what will the operator *do with the output*?) + operator stance (familiar / weakly-held / unfamiliar).
2. **Pre-flight** - The engine names what it expects, what it's borrowing from prior runs, and what it's watching for, including a quality gate (1-3 concrete success criteria).
3. **Diverge** - The engine generates questions tagged by category. The operator prunes in passes: strike junk, add inline constraints, tag dependencies, star 3-5 for the answer cluster, and capture new questions.
4. **Answer pass** - The engine answers a cluster of questions that share an intent. The interesting behavior shows up *between* the answers.
5. **Converge** - Output shape follows the intent and operator stance (verdict, meaning-map, axis-map, stakeholder atlas, precondition-monitoring, decidability-reframe, ...).
6. **Process observations** - What did this run change about how we think the loop should work? Update `notes/engine-notes.md` and `notes/seed-patterns.md`.

## What it's shown so far

Nine runs in, the loop has demonstrated:
- Eight distinct output shapes across nine runs, one per intent (with run 007 reusing run 003's axis-map). Output shape follows intent, and for Decision-oriented seeds, also the operator's stance.
- That the initial role reshapes divergence: the Evidence role (runs 008-009) opens a *provenance / quality / reach* lens a Claim run lacks, and the engine-task decides where that lens lands.
- A growing meta-edge vocabulary between answers (e.g., *symmetrizes*, *operationalizes*, *constrains-the-decidability*, *aliases*, *dissolves*, *co-produces*).
- Five distinct prune patterns, including prune-as-analytical-center - which turns out to need both operator expertise and an intent that invites discharging self-checks.
- That the same role+intent can produce mechanically different patterns depending on the operator's stance toward the seed.

The accumulated beliefs live in [`notes/engine-notes.md`](https://github.com/solvaholic/inquiry-loop/blob/main/notes/engine-notes.md), each tagged by how much evidence supports it.

## Links

- **Source**: [solvaholic/inquiry-loop](https://github.com/solvaholic/inquiry-loop)
- **Start here**: [runs/001-truth-edges-of-attention.md](https://github.com/solvaholic/inquiry-loop/blob/main/runs/001-truth-edges-of-attention.md)
- **What we believe so far**: [notes/engine-notes.md](https://github.com/solvaholic/inquiry-loop/blob/main/notes/engine-notes.md)
