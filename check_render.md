---
layout: default
type: home
---

{% if site.github.public_repositories.size > 0 %}
    {% for repo in site.github.public_repositories %}
**[{{ repo.name }}]({{ repo.url }})** / {{ repo.updated_at | date: '%b %-d, %Y' }}
    {% endfor %}
{% else %}
    No repos yet!
{% endif %}
