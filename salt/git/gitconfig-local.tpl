[core]
  excludesFile = ~/.config/git/gitignore
  sshCommand = ssh -i {{ identityfile }}

[user]
  email = {{ email }}
  name = {{ pillar.fullname }}

