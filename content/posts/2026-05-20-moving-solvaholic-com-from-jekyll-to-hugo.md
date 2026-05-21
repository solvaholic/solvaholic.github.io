---
title: "Moving solvaholic.com from Jekyll to Hugo"
date: 2026-05-20T14:17:32-04:00
slug: "moving-solvaholic-com-from-jekyll-to-hugo"
tags: []
draft: true
---

After four years of benign neglect, solvaholic.com got a full rebuild: Jekyll out, Hugo in, GitHub Actions for deploys, and a setup designed to stay fresh without constant babysitting. GitHub Copilot handled the heavy lifting, and the site's new scaffolding tools already paid off - this post was drafted with them.

---

My personal site had been running on Jekyll since 2017. The last post went up in August 2021, and by early 2026 the repo was a patchwork of tweaks, pinned gems, and vibes. Every time I thought about touching it, I had to fight Ruby version drama before writing a single line. That's a great way to never write anything.

So I blew it up. Not deleted - We tagged the old state at `archive/jekyll-2021` and did a rip-and-replace on a fresh branch. The goals were straightforward: switch to Hugo so dependency headaches are someone else's problem, deploy via GitHub Actions instead of branch deploys, pick a theme that respects dark mode without extra work, and set up automation so the site doesn't bit-rot again in four years. GitHub Copilot worked alongside me through the whole thing, and it made a real difference on the tedious parts - migrating 24 posts, normalizing date formats, wiring up the deploy workflow - the kind of work that's easy to get right with a second set of eyes and miserable to do alone.

The theme is PaperMod, pulled in as a Hugo module (not a submodule) so Dependabot can track updates through the `gomod` ecosystem. That one decision quietly solved half the "stays fresh" problem. The other half is a small `bump-hugo.yml` workflow that opens a weekly PR when a new Hugo release drops - because Dependabot doesn't track the Hugo binary itself. Config is split across four files, there's a `Makefile` for the common authoring commands, and archetypes enforce sensible front matter defaults so new posts start clean. There were a few surprises along the way - Hugo deprecated `languageCode` in v0.158, date formats needed an RFC3339 normalization pass, and browsers cache favicons with a stubbornness that borders on personal - but nothing that took long to sort out. The site is leaner, the tooling is honest, and this post was the first thing drafted with the new scaffolding scripts. So far, so good.
