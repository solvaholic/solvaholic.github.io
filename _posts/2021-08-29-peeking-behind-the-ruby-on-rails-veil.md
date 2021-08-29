---
layout: post
title: Peeking behind the Ruby on Rails veil
tags: ruby rails coding
date: 2021-08-29 12:00 -0400
---

A big part of my job since 2017 has been supporting a Ruby on Rails app. 'Til now I've gotten by on my infrastructure, server, and troubleshooting skills. Ruby on Rails has been a blind spot for me, though, and it's time to fix that.

Most of my debugging experience has been around a monolithic C project. I like C: It's easy to follow, to find your way around. In all I've used about two dozen programming and scripting languages. I'm no software developer, however.

Troubleshoot, debug, hack, or improve? Yes. Create a useful application whole? No. Well, I did make a PHP/MySQL thing once. Point being: I've a tonne of practice reading code. But [Ruby on Rails] has been completely opaque to me.

_Convention over configuration_ is what I keep stumbling over. This is how it typically feels when I ask for help debugging a Rails app:

Me: Where is this defined?  
Rubyist: What are you trying to do? I'll figure it out for you.

So I did my best to forget how to read code, cracked open my copy of [_Rails Crash Course_], and dug in. Then I got frustrated and quit. Then I tried again, got bored, and quit. Then I tried again, got distracted, and didn't go back.

I even attempted contributing to a different Rails app, and failed miserably. Have you tried making new changes pass someone else's [vcr] tests? If you're a beginner like me, start with a project that doesn't use vcr.

I'm giving _Rails Crash Course_ another go. This time I made it far enough in to see some of the elegant beauty Rails provides. I see the appeal now, and I'm picking up on some of those conventions.

[solvaholic/animated-potato] is where I'm turning this crank, in case you'd like to see.

[Ruby on Rails]: https://rubyonrails.org
[_Rails Crash Course_]: https://nostarch.com/railscrashcourse
[vcr]: https://rubygems.org/gems/vcr
[solvaholic/animated-potato]: https://github.com/solvaholic/animated-potato