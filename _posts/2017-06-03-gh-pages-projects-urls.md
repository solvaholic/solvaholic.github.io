---
layout: post
title: Making sense of URLs in GitHub Pages for projects
date: 2017-06-03 14:00:00
excerpt_separator: <!--more-->
tags:
---

I used GitHub Pages' `site.github.public_repositories` to [list all my public Repositories](https://solvaholic.github.io/repos.html). I wanted to list pages in a [Collection](https://jekyllrb.com/docs/collections/) in a similar way for the [`solvahol/ghkb`](https://github.com/solvahol/ghkb) project. Because [GitHub Pages addresses the project as a subdirectory](https://help.github.com/articles/user-organization-and-project-pages/) of the owner's Pages site, this was less straightforward than I expected.

<!--more-->
Here are my notes about what I found and how I made sense of it. Here's the general solution I arrived at:

1. Create a project Repository on GitHub, configured to serve GitHub Pages
2. Configure a Jekyll Collection and add content
3. Customize the `permalink` URL for pages in the collection
4. Use `site.github.url` to prepend the Pages URL in links

ilovesymposia.com summarizes [several caveats of letting GitHub Pages render Jekyll sites](https://ilovesymposia.com/2015/01/04/some-things-i-learned-while-building-a-site-on-github-pages/), including the challenge of writing URLs for links in a project's Pages site.

He points to the [Jekyll documentation](http://jekyllrb.com/docs/github-pages/), which recommends using `site.github.url` to prepend the project site URL in links.

### Basic setup
- Create a project Repository on GitHub, for example:
    - `https://github.com/owner/repo`
- Configure GitHub Pages on `owner/repo`
    - The Repository's Pages URL is like `https://owner.github.io/repo`
- [Create the Collection configuration in `_config.yml`]({{ site.github.url }}{% post_url 2017-06-03-jekyll_collections %}):
    ```
    collections:
      coll-name:
        output: true
    ```
- Author content in `<source>/_coll-name`, for example `a-file.md`:
    ```text
    ---
    ---
    # Here is a heading
    Words words words
    ```

- After these changes are pushed to `owner/repo`, the content will become available at `https://owner.github.io/repo/coll-name/a-file.html`

### Use `permalink` to modify the Collection URL
- Edit the Collection configuration in `_config.yml`:
    ```text
    collections:
      coll-name:
        output: true
        permalink: /my-collection/:title.html
    ```
- After these changes are pushed to `owner/repo`, the content will become available at `https://owner.github.io/repo/my-collection/a-file.html`

### Writing links to content
If you want to see your changes before you publish them, render the site locally with `jekyll serve`. The project repository doesn't exist locally so you'll see `a-file.html` rendered at `http://localhost:4000/my-collection/a-file.html`.

This can present a problem because it may work locally and fail when pushed to GitHub:

{% raw %}
```text
<ul>
{% for a-page in site.coll-name %}
    <li>
        <a href="{{ a-page.url }}">{{ a-page.title }}</a>
        {{ a-page.excerpt }}
    </li>
{% endfor %}
</ul>
```
{% endraw %}

That code will create a link to `/my-collection/a-file.html`, which won't work in `owner/repo` because it's missing `/repo` at the beginning. If you write in the `/repo` that won't work when you test locally.

[One solution for this problem](http://jekyllrb.com/docs/github-pages/) is to write links using `site.github.url` to fill the beginning of the URL:

{% raw %}
```
<ul>
{% for a-page in site.coll-name %}
    <li>
        <a href="{{ site.github.url }}{{ a-page.url }}">{{ a-page.title }}</a>
        {{ a-page.excerpt }}
    </li>
{% endfor %}
</ul>
```
{% endraw %}

That code will fill in the beginning of the URL when rendered on GitHub, and will leave it out when rendered locally.
