---
layout: post
title: Publish a Project Template Programmatically
date: 2017-04-15 01:00:00
excerpt_separator: <!--more-->
tags: notes
---

"Hey, we should &lt;bright idea&gt;!"

When we write that idea down there are several questions we'll want to answer before we do much else with it. When we make a Repository on GitHub for one of these bright ideas, we can populate some Issues and a Project by default.
<!--more-->

## A project template includes ...

### Several Issues
* What is the problem?
  ```
  {"title": "What is the problem?",
  "body": "The problem we imagine is ...",
  "labels": ["question"]}
  ```
* Who has this problem?
  ```
  {"title": "Who has this problem?",
  "body": "Describe the people or personas who have this problem.",
  "labels": ["question"]}
  ```
* What solutions exist?
  ```
  {"title": "What solutions exist?",
  "body": "What work has already been done to solve this problem?",
  "labels": ["question"]}
  ```
* What will we do about it?
  ```
  {"title": "What will we do about it?",
  "body": "How will we solve this problem? (How) Will our solution be better?",
  "labels": ["question"]}
  ```

### A Project with Columns
Create a Project named `<repo-name> board` in the Repository. Add these Columns to it:
* Now - Add all four Issues to this Column
* Next
* Later

### Other / Misc / Future / ???
* (?) README.md template with links to Project and Issues areas
* (?) Customized Labels

## Manual walkthrough ...

### This walkthrough uses `curl` and `bash`
For this walkthrough we'll use `curl` and shell environment variables. Substitute tools of your choice.

### Know where to find the instructions
I started with [https://developer.github.com/v3/](https://developer.github.com/v3/) and [https://google.com](https://google.com)

Note: Some GitHub APIs, like [the Projects API](https://developer.github.com/v3/projects/), have special access requirements.

### Create a Repository
Create a project Repository with .gitignore, LICENSE.md, and README.md

I made [https://github.com/solvaholic/projecter](https://github.com/solvaholic/projecter)

### Get a Personal Access Token
You can get yours here: [https://github.com/settings/tokens](https://github.com/settings/tokens)

The API calls we're using require the `repo` scope.

For convenience let's make some variables:
```
$ mytoken=YOURTOKENHERE
$ head1='Authorization: token '$mytoken
$ head2='Accept: application/vnd.github.inertia-preview+json'
```

### Get Repository metadata
[https://developer.github.com/v3/repos/#get](https://developer.github.com/v3/repos/#get)

When you script this solution, grab data about the Repository from the API responses.
```
$ curl -H "$head1" https://api.github.com/repos/solvaholic/projecter
```

That will return, for example:
```
"name": "projecter",
"url": "https://api.github.com/repos/solvaholic/projecter",
"issues_url": "https://api.github.com/repos/solvaholic/projecter/issues{/number}",
```

### Create templated Issues
[https://developer.github.com/v3/issues/](https://developer.github.com/v3/issues/)

```
$ issues_url='https://api.github.com/repos/solvaholic/projecter/issues'
$ curl -X POST -H "$head1" $issues_url -d '{"title": "What is the problem?", "body": "The problem we imagine is ...", "labels": ["question"]}'
$ curl -X POST -H "$head1" $issues_url -d '{"title": "Who has this problem?", "body": "Describe the people or personas who have this problem.", "labels": ["question"]}'
$ curl -X POST -H "$head1" $issues_url -d '{"title": "What solutions exist?", "body": "What work has already been done to solve this problem?", "labels": ["question"]}'
$ curl -X POST -H "$head1" $issues_url -d '{"title": "What will we do about it?", "body": "How will we solve this problem? (How) Will our solution be better?", "labels": ["question"]}'
```

We're going to need those `id`'s later:
```
"id": 221928483,
"number": 1,

"id": 221928730,
"number": 2,

"id": 221928817,
"number": 3,

"id": 221928833,
"number": 4,
```

### Create Project and Columns
[https://developer.github.com/v3/projects/](https://developer.github.com/v3/projects/)

```
$ projects_url='https://api.github.com/repos/solvaholic/projecter/projects'
$ curl -X POST -H "$head2" -H "$head1" $projects_url -d '{"name": "projecter board"}'
```

Grab that `columns_url` so we can add Columns to our new Project:
```
"columns_url": "https://api.github.com/projects/538568/columns",
```

[https://developer.github.com/v3/projects/columns/](https://developer.github.com/v3/projects/columns/)

```
$ columns_url='https://api.github.com/projects/538568/columns'
$ curl -X POST -H "$head2" -H "$head1" $columns_url -d '{"name": "Now"}'
$ curl -X POST -H "$head2" -H "$head1" $columns_url -d '{"name": "Next"}'
$ curl -X POST -H "$head2" -H "$head1" $columns_url -d '{"name": "Later"}'
```

Next we'll need the `cards_url` of the `Now` column:
```
"cards_url": "https://api.github.com/projects/columns/911205/cards",
```

### Add Issue Cards to Project Columns
[https://developer.github.com/v3/projects/cards/](https://developer.github.com/v3/projects/cards/)

When you add cards they will push into the top of the column:
```
$ now_cards_url='https://api.github.com/projects/columns/911205/cards'
$ curl -X POST -H "$head2" -H "$head1" $now_cards_url -d '{"content_type": "Issue", "content_id": 221928833}'
$ curl -X POST -H "$head2" -H "$head1" $now_cards_url -d '{"content_type": "Issue", "content_id": 221928817}'
$ curl -X POST -H "$head2" -H "$head1" $now_cards_url -d '{"content_type": "Issue", "content_id": 221928730}'
$ curl -X POST -H "$head2" -H "$head1" $now_cards_url -d '{"content_type": "Issue", "content_id": 221928483}'
```
