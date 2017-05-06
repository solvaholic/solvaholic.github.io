---
layout: default
title: Migrating promiscuousideas.com to GitHub Pages
date: 2017-05-04 20:15:01
excerpt_separator: <!--more-->
tags:
---

In July 2016 I put a blog up [on WiX at promiscuousideas.com](http://mrwinans.wixsite.com/promiscuousideas). I loved the easy-to-use interface, huge feature set, and beautiful templates. I've thought and learned a lot since then about what I want promiscuousideas.com and idsx.co to do, and it's time to move them to GitHub.
<!--more-->

# A few of my favorite things
[The WiX site](http://mrwinans.wixsite.com/promiscuousideas) has a huge blue block up top that shouts at visitors:

BE PROMISCUOUS WITH YOUR IDEAS

The recent post titles and excerpts appear arranged in a way that I think makes sense for any screen size.

At the footer there are social media links and a questionably useful _About Us_ blurb.

I want to port all these to GitHub Pages in a way that embraces the simplicity of the platform.

# The hard part is ...
The one piece of that I had no idea how to do was the dynamic layout of post excerpts. How to change the display from 3 columns, to 2, to 1 based on the width of the display?

First I studied several examples provided in [_20 Amazing Examples of Using Media Queries for Responsive Web Design_ from designshack.com](https://designshack.net/articles/css/20-amazing-examples-of-using-media-queries-for-responsive-web-design/) to find the handful of CSS that makes it work.

Then, starting with [the Cayman theme for GitHub Pages](https://github.com/pages-themes/cayman), I added `assets/css/style.scss` to my repository:

{% raw %}
```text
---
---

@import 'jekyll-theme-cayman';

.posts-pane {
  list-style: none;
  list-style-type: none;
  padding: 0;
}

li.post-block {
  display: inline-block;
  padding: 1rem;
  text-align: left;
  vertical-align: top;
  @include large {
    width: 32.9505%;
  }
  @include medium {
    width: 49.42575%;
  }
  @include small {
    width: 98.8515%;
  }
}

h3.post-block {
  margin-bottom: 0;
}
```
{% endraw %}

Then I made a Recent Posts list for `index.html` using [some examples I found on stackoverflow.com](http://stackoverflow.com/questions/17890493/how-can-i-show-just-the-most-recent-post-on-my-home-page-with-jekyll):

{% raw %}
```text
{% if site.posts.size > 0 %}
    <ul class="posts-pane">
    {% for post in site.posts limit:6 %}
        <li class="post-block">
            <h3 class="post-block"><a href="{{ post.url }}">{{ post.title }}</a></h3>
            {{ post.excerpt }}
        </li>
    {% endfor %}
    </ul>
{% else %}
    <p>No posts yet!</p>
{% endif %}
```
{% endraw %}

Taking advantage of the pre-existing styles in GitHub Pages it was simple to dynamically arrange the post excerpts.

# Importing content from WiX and Blogger
I took these (with minor edits) from [solvaholic.blogspot.com](https://solvaholic.blogspot.com) and [WiX](http://mrwinans.wixsite.com/promiscuousideas) and posted them on my own blog, here, at [solvaholic.github.io](https://solvaholic.github.io/):
* [Do I have to solve this problem?]({% post_url 2015-09-20-do-i-have-to-solve-this-problem %})
* [What problem?]({% post_url 2015-09-21-what-problem %})
* [Look at the tire]({% post_url 2015-09-22-look-at-the-tire %})
* [Are you willing to be wrong?]({% post_url 2015-09-23-are-you-willing-to-be-wrong %})
* [Which kind of ASS are UME?]({% post_url 2015-09-28-which-kind-of-ass-are-ume %})
* [Why do we still have this problem?]({% post_url 2015-09-29-why-do-we-still-have-this-problem %})

These I took from [WiX](http://mrwinans.wixsite.com/promiscuousideas) straight to [Promiscuous Ideas](https://promiscuous-ideas.github.io):
* [A flare for idea sex](https://promiscuous-ideas.github.io/2016/07/13/a-flare-for-idea-sex.html)
* [Why "Idea Sex"?](https://promiscuous-ideas.github.io/2016/07/13/why-idea-sex.html)
