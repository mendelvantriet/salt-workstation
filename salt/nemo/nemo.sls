nemo_packages:
  pkg.installed:
    - pkgs:
      - nemo
      - nemo-fileroller

nemo_configuration:
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

