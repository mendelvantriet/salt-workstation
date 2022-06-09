file_browser_packages:
  pkg.installed:
    - pkgs:
      - nemo
      - nemo-fileroller

file_browser_configuration:
  cmd.run:
    - runas: "{{ pillar['user'] }}"
    - names:
      - gsettings set org.gnome.desktop.background show-desktop-icons false
      - gsettings set org.nemo.desktop show-desktop-icons false
      - gsettings set org.nemo.list-view default-visible-columns "['name', 'size', 'date_modified', 'permissions']"
      - gsettings set org.nemo.preferences date-format iso
      - gsettings set org.nemo.preferences default-folder-viewer 'list-view'
      - gsettings set org.nemo.preferences show-advanced-permissions true
      - gsettings set org.nemo.window-state sidebar-bookmark-breakpoint 3

/home/{{ pillar['user'] }}/.config/gtk-3.0/bookmarks:
  file.managed:
    - source: salt://nemo/bookmarks
    - user: "{{ pillar['user'] }}"
    - group: "{{ pillar['group'] }}"
    - template: jinja
    - makedirs: True

