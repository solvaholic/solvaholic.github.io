---
layout: post
title: Update Node.js And Packages
date: 2017-03-02 08:18:30
tags:
---

Each time I go to use a Node.js package on my laptop I wonder how to upgrade Node.js and its packages. Homebrew would make it easier, so next I'll wonder why I'm not using that. For now, though, here's a way to upgrade Node.js and packages...

<!-- more -->

# Get n, if it's not already there
Thank you [stackoverflow.com](http://stackoverflow.com/questions/8191459/how-do-i-update-node-js)!

    $ npm cache clean
    $ npm install -g n

# Upgrade Node.js
Note: Because of environment variable dependencies you may have to log out and log back in before 'node -v' will show you the upgraded version.

    $ sudo n stable

# Upgrade Node.js Packages
I'm using npm. Apparently there are alternatives?

    $ npm --depth 9999 upgrade
    $ npm --depth 9999 upgrade -g
