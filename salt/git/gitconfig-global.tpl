[core]
  excludesFile = ~/.config/git/gitignore

[user]
  email = {{ pillar.email }}
  name = {{ pillar.fullname }}

{% for organization in pillar.git.organizations %}
[includeIf "gitdir:~/git/{{ organization.name }}/"]
path = ~/git/{{ organization.name }}/.gitconfig
{% endfor %}

