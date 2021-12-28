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
      - gsettings set org.nemo.list-view default-visible-columns "['name', 'size', 'permissions']"
      - gsettings set org.nemo.preferences date-format iso
      - gsettings set org.nemo.preferences default-folder-viewer 'list-view'
      - gsettings set org.nemo.preferences show-advanced-permissions true

file_browser_bookmarks:
  file.append:
    - name: /home/{{ pillar['user'] }}/.config/gtk-3.0/bookmarks
    - text: {{ pillar['file_browser']['bookmarks'] }}
