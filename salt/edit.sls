edit_packages:
  pkg.installed:
    - pkgs:
      - gedit
      - gedit-plugins

edit_configuration:
  cmd.run:
    - runas: "{{ pillar['user'] }}"
    - names:
      - gsettings set org.gnome.gedit.preferences.editor display-line-numbers true
      - gsettings set org.gnome.gedit.preferences.editor tabs-size 4
      - gsettings set org.gnome.gedit.preferences.editor auto-indent true
      - gsettings set org.gnome.gedit.plugins active-plugins "['time', 'codecomment', 'filebrowser', 'bookmarks', 'modelines', 'git', 'docinfo', 'spell', 'restoretabs', 'controlyourtabs']"


