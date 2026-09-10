gedit_packages:
  pkg.installed:
    - pkgs:
      - gedit
      - gedit-plugins

gedit_configuration:
  cmd.run:
    - runas: "{{ pillar['user'] }}"
    - names:
      - gsettings set org.gnome.gedit.preferences.editor display-line-numbers true
      - gsettings set org.gnome.gedit.preferences.editor insert-spaces true
      - gsettings set org.gnome.gedit.preferences.editor tabs-size 2
      - gsettings set org.gnome.gedit.preferences.editor auto-indent true
      - gsettings set org.gnome.gedit.plugins active-plugins "['time', 'codecomment', 'filebrowser', 'bookmarks', 'modelines', 'git', 'docinfo', 'spell', 'restoretabs', 'controlyourtabs']"


