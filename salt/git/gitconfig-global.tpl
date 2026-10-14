[core]
  excludesFile = ~/.config/git/gitignore

[user]
  email = {{ pillar.email }}
  name = {{ pillar.fullname }}

{% for tenant in pillar.git.tenants %}
[includeIf "gitdir:~/git/{{ tenant.name }}/"]
path = ~/git/{{ tenant.name }}/.gitconfig
{% endfor %}

