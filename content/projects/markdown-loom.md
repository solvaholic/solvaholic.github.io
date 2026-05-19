---
title: "Markdown Loom"
date: 2026-05-19T19:55:00-04:00
summary: "VS Code extension for wiki-style linking and backlinks across plain Markdown notes. No proprietary formats, no sidecar database, just .md files."
tags: ["vscode", "markdown", "notes", "wikilinks"]
weight: 10
cover:
  image: "https://github.com/solvaholic/markdown-loom/raw/main/docs/demo.gif"
  alt: "Markdown Loom demo"
  relative: false
---

[Markdown Loom](https://github.com/solvaholic/markdown-loom) is a VS Code
extension for plain-Markdown note taking. It adds **wiki-style linking**
and a **backlinks panel** across a folder of `.md` files - no proprietary
formats, no sidecar database, just markdown.

## What's in it

- **Wikilinks**: type `[[` to autocomplete from any `.md` in your
  workspace. Cmd/Ctrl+click to jump. `[[Note|Alias]]` for aliased link
  text. Rendered as clickable links in the Markdown preview.
- **Click-to-create**: clicking a `[[link]]` to a missing note offers
  to create it (configurable: prompt / auto / never), with a
  configurable location.
- **Section and block refs**: `[[Note#Heading]]` and `[[Note#^blockid]]`
  resolve in the editor and the preview.
- **Backlinks panel**: shows every note that links to the active file,
  grouped by source with line previews. Refreshes on file switch and on
  save.
- **Filename collisions surface as warnings**: when a bare `[[Foo]]`
  matches multiple notes, navigation picks one winner via a
  same-folder tiebreaker, and the others are flagged ambiguous so you
  can spot and resolve.
- **Rename-aware**: links are rewritten when VS Code renames a file.

## Why another note-taking extension?

Most VS Code note tools either invent a format, lean on a database, or
bundle a kitchen sink of Markdown ergonomics. Markdown Loom does one
thing well: it makes a folder of plain `.md` files feel like a connected
notebook. Pair it with [Markdown All in One](https://marketplace.visualstudio.com/items?itemName=yzhang.markdown-all-in-one)
for editing ergonomics; the two coexist cleanly.

For richer task workflows, open the same `.md` files in
[Obsidian](https://obsidian.md). Loom ships a small
Obsidian-Tasks-compatible toggle (Ctrl/Cmd+Alt+T, auto-stamps a done
date), but task features are frozen - the format-portable note graph is
the focus.

## Links

- **Marketplace**: [Markdown Loom on VS Code Marketplace](https://marketplace.visualstudio.com/items?itemName=solvaholic.markdown-loom)
- **Source**: [solvaholic/markdown-loom](https://github.com/solvaholic/markdown-loom)
- **Spec**: [docs/SPEC.md](https://github.com/solvaholic/markdown-loom/blob/main/docs/SPEC.md)
- **Comparisons with other extensions**: [docs/comparisons.md](https://github.com/solvaholic/markdown-loom/blob/main/docs/comparisons.md)
