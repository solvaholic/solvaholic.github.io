---
title: "Inquiry Loop"
date: 2026-06-03T19:54:26-04:00
summary: "An experimental diverge-graph-converge engine for research and sensemaking - currently a deliberately low-tech prototype run by hand, one markdown note at a time."
tags: ["research", "sensemaking", "prototyping", "llm", "critical-thinking"]
weight: 5
---

[inquiry-loop](https://github.com/solvaholic/inquiry-loop) is an experimental inquiry engine: a diverge-graph-converge loop for research and sensemaking. Most AI research tools try to hand you an answer; this one helps you map the questions. Instead of treating statements as simple true/false propositions, it tracks how they *function* in context - as claims to test, evidence to weigh, or assumptions to challenge. It's a branching, automated "Five Whys" meant to augment human critical thinking rather than bypass it.

## Current state: manual prototype

There's no engine yet, and that's on purpose. The repo is a low-tech prototype: each run is a single markdown note in [`runs/`](https://github.com/solvaholic/inquiry-loop/tree/main/runs), driven by an operator working with an LLM in conversation. The point is to watch how the loop *actually behaves* on real seeds before designing any schema or code around it. The current rule: **resist formalizing until the prose breaks.**

## How a run works

1. **Seed** - a statement plus an initial role (Claim / Evidence /
   Assumption / Question) and an intent (what the operator wants from
   the run).
2. **Pre-flight** - the engine names what it expects, what it's borrowing
   from prior runs, and what it's watching for.
3. **Diverge** - the engine generates questions tagged by category; the
   operator prunes (stars, strikes, notes).
4. **Answer pass** - the engine answers a cluster of questions that share
   an intent. The interesting behavior shows up *between* the answers.
5. **Converge** - the output shape follows the intent (verdict,
   meaning-map, axis-map, stakeholder atlas, and others as they emerge).
6. **Process observations** - what did this run change about how we think
   the loop should work? The notes update from the runs.

## What it's shown so far

Six runs in, the loop has produced six distinct output shapes (one per intent type), surfaced meta-edges between answers (*symmetrizes*, *operationalizes*, *constrains-the-decidability*), and revealed four distinct prune patterns - including one where the prune itself becomes the analytical center, which turns out to be mediated by operator expertise rather than by the seed's role.

The accumulated beliefs live in [`notes/engine-notes.md`](https://github.com/solvaholic/inquiry-loop/blob/main/notes/engine-notes.md), each tagged by how much evidence supports it.

## Links

- **Source**: [solvaholic/inquiry-loop](https://github.com/solvaholic/inquiry-loop)
- **Start here**: [runs/001-truth-edges-of-attention.md](https://github.com/solvaholic/inquiry-loop/blob/main/runs/001-truth-edges-of-attention.md)
- **What we believe so far**: [notes/engine-notes.md](https://github.com/solvaholic/inquiry-loop/blob/main/notes/engine-notes.md)
