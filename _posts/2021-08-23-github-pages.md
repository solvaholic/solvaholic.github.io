---
layout: post
title: Using GitHub Pages
date: 2021-08-23 16:00:00
excerpt_separator: <!--more-->
tags: notes how-to gh-pages
permalink: github-pages.html
---

Coming back to GitHub Pages after nearly four years has been fun. And educational. Spending a little time around Ruby, and a lot of time around GitHub, has filled in some illuminating perspective.

<!--more-->

Here are my notes about getting going with GitHub Pages. Again. This time.

## Use Homebrew

It's probably already there on macOS, and it works great with Linux too.

For a stable starting point, this walkthrough uses an `ubuntu:20.04` Docker container. After installing prerequisite packages, though, the steps should work on any modern Linux.

For what it's worth: This whole setup was trivial on macOS, easy on PopOS!, and easy enough on `ubuntu:20.04` (as documented here). On `debian:buster` I gave up chasing dependency problems after a couple hours.

To discover which dependencies you need, follow the prompts and/or find a walkthrouh for your operating system. To run [Homebrew] on a Ubuntu 20.04 Docker container, a few packages are required:

```text
apt update && \
apt install -y curl git build-essential procps gcc zlib1g-dev sudo nvi
```

The container ran as `root` by default and I prefer not to work as `root` - especially when running commands like `bundle install`. Here's how I put my non-root user in the container:

```
useradd -c "" -m -p "" -s /bin/bash user1
usermod -aG sudo user1
su - user1
```

Use `sudo` once more while [installing Homebrew]:

```text
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

Then follow the instructions it provides:

```text
echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"' >> /home/user1/.profile
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
```

[Homebrew]: https://brew.sh/
[installing Homebrew]: https://github.com/Homebrew/install

## Use `rbenv`

[rbenv] may feel like extra work if you plan to use just one installation of Ruby. Using it will help you avoid permissions problems, though. And if you're already using it by the time you realize you need a different Ruby that experience will suck a lot less.

```text
brew install rbenv
rbenv init
echo 'eval "$(/home/linuxbrew/.linuxbrew/bin/rbenv init -)"' >> ~/.bashrc
eval "$(rbenv init -)"
rbenv install -l
rbenv install 2.7.4
rbenv global 2.7.4
rbenv rehash
```

Note: I edited that `rbenv` path. Your path to `rbenv` may be different. Use `which -a rbenv` to find the correct one.

[rbenv]: https://github.com/rbenv/rbenv

## Use `bundle`

[Bundler] may feel like extra work if you plan to use just one application with Ruby. Using it will help you avoid permissions problems, though. And if you're already using it by the time you realize you use more than one application that experience will suck a lot less.

```text
gem install bundle
```

[Bundler]: https://bundler.io/

## But why?

To herd dependencies between applications they're working on, software developers use a handful of tricks and hacks that keep everything neat and tidy. You don't have to use [rbenv] and [Bundler]. You could use neither, or use an alternative. But if you do use them you won't have to deal directly with all that dependency-herding bullshit. You'll be able to check `rbenv version` and run `bundle install` in whichever application directory and you're set.

After you have a Ruby version manager and a Gem manager set up and working, they just keep working.

## Install `jekyll`

It's tempting to go ahead and run `gem install jekyll`. And that will probably work OK. If you let `bundle` get it, though, you can keep ignoring the complexity of what it takes to develop >1 application on one workstation.

I let GitHub [create a Pages site] for me, then made a bunch of customizations. To illustrate that process, setting up a customized Pages site, I put together this demo:

<https://github.com/solvaholic/reimagined-fortnight/commits/main>

The commit history explains the steps. Read the comments.

To illustrate setting up a workstation to edit and test a GitHub pages site, I'll start with that repository.

```text
mkdir -p ~/repos/pages
git clone https://github.com/solvaholic/reimagined-fortnight.git ~/repos/pages
cd ~/repos/pages
```

There's no Gemfile yet, so create one. And then wave that magic wand:

```text
cat > Gemfile <<EOM
source 'https://rubygems.org'
gem 'github-pages'
EOM

bundle install
```

If you run `git status` to see what changed, it'll tell you `Gemfile` and `Gemfile.lock` have been created. You don't need to grok those for this, but I encourage you to spend 15 minutes learning about them anyway.

[create a Pages site]: https://pages.github.com/

## Make the site yours

Look through all the files in the repository to get an idea of what's where, how things are organized. At a minimum, from this example repository, you'll want to modify these three files:

- `_config.yml`: Set your `title` and `description`.
- `_includes/links.html`: Edit links to link to your sites.
- `_includes/links-mobile.html`: Edit links to link to your sites.

## Test the site

Whenever you're ready to check it out in the browser, run the server:

```text
bundle exec jekyll serve
```

It'll tell you how to access the site.

## Figure out what went wrong

... or just work around it. Undoubtedly, something is different in your environment from whatever I did that worked. For example, in the Ubuntu container `jekyll serve` never did work right. And in PopOS! it served a file/folder list until I added `index.html`. On macOS it just works, but a lot of my environment there was set up previously. /shrug