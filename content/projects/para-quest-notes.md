---
title: "Para Quest Notes"
date: 2026-06-04T20:28:50-04:00
summary: "Local, scripted markdown-note workflows that marry the PARA method with a quest-based prioritization model - so day-to-day filing stays aligned with long-term goals, and your notes never leave your machine."
tags: ["notes", "para", "llm", "local-first", "copilot", "cli"]
weight: 4
draft: false
---

[para-quest-notes](https://github.com/solvaholic/para-quest-notes) is a set of local, scripted workflows for managing markdown notes, powered by small LLMs running locally via [Ollama](https://ollama.com/). The premise is simple: most "AI for notes" tools want to ship your notes to someone else's servers. This one doesn't. Plain Python does as much as possible, and a local model is only called for the bits that genuinely need natural-language judgment - classification, summarization, escalating when the rules don't fit.

## PARA + Quest: the part I'm most excited about

The organizing idea is to layer a **Quest** model on top of the **PARA** method. PARA answers *what kind of note is this?* - every note is a Project, Area, Resource, or Archive. Quests answer *why does this work matter?* - Areas and Projects are tagged as a Main Quest (core values and long-term goals), a Side Quest (supports a Main Quest), or a time-bound Project that advances one of them. Filing isn't just tidying; it's a small act of prioritization. The full spec lives in [`docs/notes-system.md`](https://github.com/solvaholic/para-quest-notes/blob/main/docs/notes-system.md).

## Design principles

1. **Local first.** No cloud LLM calls. Notes never leave your machine.
2. **Scripts are the brains.** LLMs only do what scripts can't: judgment calls and natural-language summarization.
3. **Small models welcome.** Targeted at models that fit on a laptop (Granite 4, Gemma 3, Qwen 3, Phi-4 reasoning, etc.).
4. **CLI first, agent-friendly.** Every workflow is a CLI you can pipe and cron, with structured JSON output as a first-class citizen - so an agent can wrap a workflow without ever seeing your note bodies.
5. **Bring your own vault.** Install once with `pipx`/`uv tool install`, then run against any vault on disk.

## The workflows

Nine `pqn-*` CLIs cover the note lifecycle, most of them needing no LLM at all:

- `pqn-validate` - read-only audit for duplicate basenames and malformed front/backmatter (no LLM)
- `pqn-ingest` - triage `inbox/` notes into their PARA + Quest home, rewriting wikilinks on rename (LLM)
- `pqn-create` - file a single new note with frontmatter pre-populated (no LLM)
- `pqn-daily` - drop a daily note into `resources/daily_notes/` (no LLM)
- `pqn-archive` - close out a Project, optionally letting the LLM draft the `## Outcome` (LLM)
- `pqn-quests` - generate a Quest index, grouping Areas and Projects by the Quest(s) they support, and ranking Resources by incoming links (no LLM)
- `pqn-tasks` - read-only reporter for scheduled or due tasks (no LLM)
- `pqn-search` - PARA + Quest-aware keyword search over title and content, ranking Resources by inbound links (no LLM)
- `pqn-config` - read-only inspector for the effective configuration with per-value provenance (no LLM)

Every CLI defaults to a dry-run, shares a uniform exit-code contract, and writes a JSONL trace you can read after the fact to see exactly which prompt produced which decision.

## Status

At `v0.5.0`, the CLI surface and JSON contracts are stable. Current work (Phase 7) is growing the evaluation fixtures and revisiting the `generate_outcome` judge.

## Links

- **Source**: [solvaholic/para-quest-notes](https://github.com/solvaholic/para-quest-notes)
- **The model**: [docs/notes-system.md](https://github.com/solvaholic/para-quest-notes/blob/main/docs/notes-system.md)
- **How the evals work**: [docs/eval.md](https://github.com/solvaholic/para-quest-notes/blob/main/docs/eval.md)
- **Try it**: the [README quickstart](https://github.com/solvaholic/para-quest-notes#quickstart-end-to-end-against-the-sample-vault) runs all eight core CLIs against a throwaway sample vault
