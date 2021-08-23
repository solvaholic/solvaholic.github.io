---
layout: post
title: How-To - Jekyll Collections
date: 2017-06-03 00:00:01
excerpt_separator: <!--more-->
tags:
---

Jekyll's Collections provide powerful tools to organize content. Ben Balter put together [an excellent write-up about using Collections with Jekyll](http://ben.balter.com/2015/02/20/jekyll-collections/). And [the Jekyll documentation](https://jekyllrb.com/docs/collections/) is super helpful as well.

<!--more-->
Here's what I did, to demonstrate Jekyll Collections:

1. Create the collection folder, `<source>/_my_collection_name`
2. [Create some pages](https://jekyllrb.com/docs/pages/) in `<source>/_my_collection_name`
3. Add the collection config to `_config.yml`:
    ```
    collections:
      my_collection_name:
        output: true
        permalink: /level1/level2/:title.html

    defaults:
      - scope:
          path: ""
          type: my_collection_name
        values:
          layout: post
    ```
4. Create a page, e.g. `<source>/allcontent.md`, to display all the content in the collection
    {% raw %}
    ```
    ---
    title: All the content in the collection
    layout: post
    permalink: allcontent.html
    ---

    {% if site.my_collection_name.size > 0 %}
        <ul>
        {% for a-content in site.my_collection_name %}
            <li>
                <strong><a href="{{ a-content.url }}">{{ a-content.title }}</a></strong> / <time datetime="{{ a-content.date | date_to_xmlschema }}">{{ a-content.date | date: '%b %-d, %Y'}}</time>
                {{ a-content.excerpt }}
            </li>
        {% endfor %}
        </ul>
    {% else %}
        <p>No content in this collection yet!</p>
    {% endif %}
    ```
    {% endraw %}
