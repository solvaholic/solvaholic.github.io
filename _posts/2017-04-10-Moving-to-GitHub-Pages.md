---
layout: default
title: Moving to GitHub Pages
tags: fixme
---

For exercise I [put blog.solvaholic.org on Amazon Web Services S3](/2017/02/08/Publish-Directly-to-S3.html) with a CloudFront front-end. I used Hexo to build the content, and pushed it up with awscli. That works and was totally worth it, and now I'm ready to do away with that complicatedness.

### Why GitHub Pages and Jekyll?
* GitHub Pages is built in and it just works
* I can push content from anywhere, even a browser
* I'm moving my projects from Trello to GitHub Projects
* Next I want to focus on workflow automation in GitHub

### It's easy as 1, 2, 3 .. right?
Yes, it is that easy. The instructions I found, though, all work with assumptions that .. um .. are unaligned with the assumptions I made.

Here are some of the resources I used :
* Barry Clark's [Build A Blog With Jekyll And GitHub Pages](https://www.smashingmagazine.com/2014/08/build-blog-jekyll-github-pages/)
* Barry Clark's [Jekyll Now (on GitHub)](https://github.com/barryclark/jekyll-now)
* [Jekyll's GitHub Pages reference](https://jekyllrb.com/docs/github-pages/)
* Jonathan McGlone's [Creating and Hosting a Personal Site on GitHub](http://jmcglone.com/guides/github-pages/)
* [The Cayman Pages Themes documentation](https://github.com/pages-themes/cayman/)

### What's the gist?
If you put Jekyll-flavored .md files in a GitHub Pages repo, GitHub Pages will render them for you just like Jekyll would have if you built the site locally and then published it.

When you use one of the Pages-supported Jekyll themes, Pages will render your site with the layouts, assets, and styles for that theme. These are available in https://github.com/pages-themes for each supported theme.

[You may override those styles and layouts by placing your versions in your repo.](https://help.github.com/articles/customizing-css-and-html-in-your-jekyll-theme/)

### Please rephrase that as bullets
The Jekyll workflow I expected is like :
1. Install and configure Jekyll
2. Create a new Jekyll site locally
3. Configure the site, select a theme
4. Add Jekyll-flavored .md files to the site
5. Build, test, and publish

The GitHub Pages Jekyll workflow is like :
1. Enable GitHub Pages and select a Jekyll theme
2. Push an index.html to the repo and remove index.md
3. Push Jekyll-flavored .md files to the repo

### What did I do?
I'll have to circle back around on this and fill in more details. Mostly :
* Enable GitHub Pages on [solvaholic/solvaholic.github.io](https://github.com/solvaholic/solvaholic.github.io)
* Select the Cayman theme
* Remove `index.md`, replace `index.html` with :

```
---
layout: default
type: home
---

{{ "{% if site.posts.size > 0 " }}%}
    <ul>
    {{ "{% for post in site.posts " }}%}
        <li>
            <strong><a href="{{ "{{ post.url " }}}}">{{ post.title }}</a></strong> / <time datetime="{{ "{{ post.date | date_to_xmlschema " }}}}">{{ "{{ post.date | date: '%b %-d, %Y' " }}}}</time>
        </li>
    {{ "{% endfor " }}%}
    </ul>
{{ "{% else " }}%}
    <p>No posts yet!</p>
{{ "{% endif " }}%}
```

* Create `/_posts` and add content to it with filenames like `2017-04-10-Post-Title.md` :

```
---
layout: default
title: Post Title
---

Paragraphs of words and stuff.
```
