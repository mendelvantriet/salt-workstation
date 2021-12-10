xfce4_default_apps:
  file.managed:
    - name: ~/.config/xfce4/helpers.rc
    - source: salt://xfce4/helpers.rc
    - makedirs: True

xfce4_custom_file_manager:
  file.managed:
    - name: ~/.local/share/xfce4/custom-FileManager.desktop
    - source: salt://xfce4/custom-FileManager.desktop
    - makedirs: True


