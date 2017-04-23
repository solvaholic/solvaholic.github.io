---
title: My Repositories
layout: default
permalink: repos.html
---

{% if site.github.public_repositories.size > 0 %}
    {% assign repos = site.github.public_repositories | sort:"updated_at" | reverse %}
    {% for repo in repos %}
        {% if repo.has_pages %}
            {% assign repo_url = repo.homepage %}
        {% else %}
            {% assign repo_url = repo.html_url %}
        {% endif %}
* **[{{ repo.name }}]({{ repo_url }})** / updated {{ repo.updated_at | date: '%b %-d, %Y'}}
        {% if repo.fork %}
  _Reference, if this is forked or in another org_
        {% endif %}
        {% if repo.description.size > 0 %}
  {{ repo.description }}
        {% endif %}
    {% endfor %}
{% else %}
No repos yet!
{% endif %}

<!---
Thinking this through

* If repo.has_pages then link to Pages URL
* Pages URL may be repos.homepage
* html_url, homepage, and pushed_at may also be interesting
--->
