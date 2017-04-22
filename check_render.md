---
layout: default
type: home
---

{% if site.github.public_repositories.size > 0 %}
    {% assign repos = site.github.public_repositories | sort:"updated_at" | reverse %}
    {% for repo in repos %}
        **[{{ repo.name }}]({{ repo.url }})** / {{ repo.updated_at | date: '%b %-d, %Y' }}
    {% endfor %}
{% else %}
    No repos yet!
{% endif %}
