---
title: "Prototyping Inquiry Loop, on Paper, Before Any Code"
date: 2026-06-03T19:50:21-04:00
slug: "2026-06-03-prototyping-inquiry-loop"
summary: "I wanted to build a research engine. Instead I ran it by hand, one markdown note at a time, with Copilot as a thought partner - and learned things that would have been invisible from inside the code."
tags: ["prototyping", "sensemaking", "llm", "copilot"]
draft: false
---

I set out to build a research engine and have, so far, written zero lines of engine code. That's the best decision I've made on this project. [inquiry-loop](https://github.com/solvaholic/inquiry-loop) is a diverge-graph-converge loop for research and sensemaking, and right now it runs entirely on paper - each run is a single markdown note, driven by me in conversation with GitHub Copilot. If I had opened with a schema and a database, I'd have shipped something tidy, confident, and wrong.

---

The temptation with an idea like this is to reach for structure immediately: define a node type, pick a graph library, sketch an API, and start filling in functions. Structure feels like progress. But I didn't actually know how the loop *behaves* yet - which questions are worth generating, what an "answer pass" should cluster, what converging even looks like for different kinds of seeds. Any schema I designed up front would have been a guess dressed up as a decision, and code has a way of freezing guesses in place. So the rule for the prototype became: **resist formalizing until the prose breaks.** Run the loop by hand, write down what happens, and let the structure earn its way in.

That patience paid off in ways I couldn't have predicted. Running the loop manually surfaced things the design would have hidden. The same claim diverges completely differently depending on the operator's *intent* - so intent had to move into the seed. Marking a seed as a Claim versus an Assumption changes the question shape, but the bigger effect is on where the analytical work happens, and that turns out to depend on how much the operator already knows about the topic, not on the role label at all. The interesting behavior, over and over, showed up *between* the answers rather than in any single one. None of that would have been visible from inside a half-built engine. It only showed up because I was slow enough to watch.

The other thing I'm genuinely excited about is what it's like to do this *with* Copilot rather than just delegating tasks to it. It hasn't been an autocomplete or a code monkey here; it's been a thought partner and a facilitator. It plays the engine in each run, generates the divergent questions, notices meta-edges between answers I'd have read right past, and helps me name patterns - "prune-as-analytical-center," "decidability-reframe" - that I can then go looking for in the next run. The pace of learning is the surprise. Six runs in, I have six distinct output shapes, four distinct prune patterns, and a [notes file](https://github.com/solvaholic/inquiry-loop/blob/main/notes/engine-notes.md) where every belief is tagged by how much evidence backs it. That's not a research velocity I could hit alone, and it's a different kind of collaboration than "write me this function."

There will be code eventually. But it'll be code that encodes things I've actually observed, not things I assumed at a whiteboard. If you want to see how the sausage isn't getting made yet, [run 001](https://github.com/solvaholic/inquiry-loop/blob/main/runs/001-truth-edges-of-attention.md) is a quick read, and the [engine notes](https://github.com/solvaholic/inquiry-loop/blob/main/notes/engine-notes.md) hold the headline beliefs. The prototype is the product, for now. The point is to learn before I build - and so far, that's exactly what's happening.
