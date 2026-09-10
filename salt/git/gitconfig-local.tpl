[core]
  excludesFile = ~/.config/git/gitignore
  sshCommand = ssh -i {{ identityfile }}

[user]
  email = {{ pillar.git.organization.email }}
  name = {{ pillar.fullname }}

