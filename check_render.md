---
layout: my-default
type: home
---

{% if site.static_files.size > 0 %}
    {% for static_file in site.static_files %}
**[{{ static_file.name }}]({{ static_file.path }})** / {{ static_file.modified_time | date: '%b %-d, %Y' }}
    {% endfor %}
{% else %}
    No static files yet!
{% endif %}

<!--- List Repositories ...
{% if site.github.public_repositories.size > 0 %}
    {% assign repos = site.github.public_repositories | sort:"updated_at" | reverse %}
    {% for repo in repos %}
**[{{ repo.name }}]({{ repo.url }})** / {{ repo.updated_at | date: '%b %-d, %Y' }}
    {% endfor %}
{% else %}
    No repos yet!
{% endif %}
-->
