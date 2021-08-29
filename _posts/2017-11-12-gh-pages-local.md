---
layout: post
title: Set up your GitHub Pages site locally
date: 2017-11-12 00:00:01
excerpt_separator: <!--more-->
tags: gh-pages
---

These are my notes about setting up your GitHub Pages site locally...

<!--more-->

See also: [GitHub's _Setting up your GitHub Pages site locally with Jekyll_ guide](https://help.github.com/articles/setting-up-your-github-pages-site-locally-with-jekyll/#platform-linux).

## Whistle while you work

```
lxc-create -t download -n gh-pages -- -d ubuntu -r xenial -a amd64
lxc-start -n gh-pages
lxc-attach -n gh-pages -- passwd ubuntu
lxc-attach -n gh-pages -- login ubuntu
```

## Install prerequisite tools

```
sudo apt update
sudo apt install git curl gcc libffi-dev ruby-ffi build-essential patch zlib1g-dev liblzma-dev ruby ruby-dev
sudo gem install bundler
```

### In case you stumble over...

- `gem install ffi`, consult your fav search engine ([example](https://github.com/bryannielsen/Laravel4-Vagrant/issues/20#issuecomment-24637973))
- `gem install nokogiri`, goto [nokogiri.org](http://www.nokogiri.org/tutorials/installing_nokogiri.html#install_with_included_libraries__recommended_)
- `You must bundle Filter gem dependencies`, follow [the link that message provides](https://github.com/jch/html-pipeline#dependencies)

## Configure Git and clone your Pages repository

```
mkdir -p -m 700 ~/repos && cd ~/repos
git config --global user.name solvaholic
git config --global user.email solvaholic@users.noreply.github.com
git clone https://github.com/solvaholic/solvaholic.github.io.git
cd solvaholic.github.io/
```

## Install `github-pages` and `:jekyll_plugins`

```
cat > Gemfile <<EOM
source 'https://rubygems.org'
gem 'github-pages', group: :jekyll_plugins
EOM
bundle install --path vendor/bundle
```

## Commit, merge, and push changes

For example:

```
git checkout -b me/write-a-post
## Write a post, for example _posts/2017-11-12-gh-pages-local.md
## Make sure it looks like you want
git add _posts/2017-11-12-gh-pages-local.md
git commit -m "Adds a new post"
git checkout master
git pull
git merge me/write-a-post
git push
```

## Write a post

Create a branch to work in and use your favorite text editor to create `_posts/2017-11-12-gh-pages-local.md`:

```
---
layout: post
title: Set up your GitHub Pages site locally
date: 2017-11-12 00:00:01
---

This is a post about setting up your GitHub Pages site locally!
```

## Make sure it looks like you want

In the root directory of your repository, use `jekyll serve` to view your GitHub pages site in your browser:

```
bundle exec jekyll serve
```

## Clean up after yourself

- Commit, merge, and push changes you want to publish
- Use `<ctrl-c>` to stop your local Jekyll server
- `exit` to exit your container
- Stop and destroy your container:

    ```
    lxc-stop -n gh-pages
    lxc-destroy -n gh-pages
    ```
