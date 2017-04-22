---
layout: default
type: home
---

{% if site.posts.size > 0 %}
    {% for post in site.posts %}
* **[{{ post.title }}]({{ post.url }})** / {{ post.date | date: '%b %-d, %Y' }}
    {% endfor %}
{% else %}
    No posts yet!
{% endif %}
