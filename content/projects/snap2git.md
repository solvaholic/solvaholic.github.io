---
title: "snap2git"
date: 2026-05-20T14:40:00-04:00
summary: "Git-powered snapshots for cloud drive folders. Invisible version control, zero copies - your files stay where they are, the history lives somewhere else."
tags: ["git", "backup", "cli", "bash"]
weight: 20

---

[snap2git](https://github.com/solvaholic/snap2git) is a single-file Bash
CLI that gives you Git history for folders that aren't Git repos -
typically cloud drive folders (iCloud, Dropbox, Google Drive, etc.) that
you don't want to put a `.git` directory inside of.

It puts the bare Git repo in `~/.snap2git/` and points it at your folder
as a work tree. Git reads files in place. No copies, no sync, no `.git`
in your synced folder.

## What it's for

- You write notes in iCloud or Obsidian or Calibre and want a real
  version history without changing your tooling.
- You want point-in-time recovery for a folder that lives in someone
  else's sync service.
- You want to diff "what changed in the last week" across a folder of
  arbitrary files.

## How it works

```
~/.snap2git/my-notes.git/   <-- Git history (bare repo, invisible)
~/CloudDrive/Notes/          <-- Your files (untouched)
```

`snap2git init` registers a worktree. `snap2git snapshot` stages and
commits the current state. Defaults exclude OS junk, cloud sync
markers, temp files, and IDE state. You can add patterns or apply
curated presets (e.g. `calibre`, `obsidian`).

## What's in it

- **Multi-repo**: snapshot, status, verify across all configured repos
  or named groups.
- **Diff and search**: compare any two snapshots; search history by
  content change (`git log -S`/`-G`) or by file glob.
- **Read-only checkouts**: extract a snapshot to a temp directory.
  Friction by design - copy files out manually so an "undo" doesn't
  accidentally sync back to your cloud folder.
- **Scheduled snapshots**: `snap2git schedule <name> <minutes>` via
  `launchd`/`cron`.
- **Tags, exclude rules, GC, shell completion** (bash and zsh), config
  validation on startup.

## Requirements

Bash 4.0+ and Git. Both ship on macOS and most Linux distributions.

## Gotcha worth knowing

On macOS, if your worktree lives in a TCC-protected location (iCloud
Mobile Documents, Desktop, Documents, Downloads), scheduled runs may
fail even when manual runs work. Your Terminal app has Full Disk
Access; `launchd`-spawned processes don't inherit it. The README walks
through three ways to resolve it - the right answer depends on how
broadly you're willing to grant FDA.

## Links

- **Source**: [solvaholic/snap2git](https://github.com/solvaholic/snap2git)
- **Releases**: [latest binary](https://github.com/solvaholic/snap2git/releases/latest)
