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

xfce4_power_manager:
  cmd.run:
    - runas: "{{ pillar['user'] }}"
    - names:
      - xfconf-query -c xfce4-power-manager -p /xfce4-power-manager/blank-on-ac -s 20
      - xfconf-query -c xfce4-power-manager -p /xfce4-power-manager/blank-on-battery -s 20
      - xfconf-query -c xfce4-power-manager -p /xfce4-power-manager/dpms-enabled -s false
      - xfconf-query -c xfce4-power-manager -p /xfce4-power-manager/dpms-on-ac-off -s 0
      - xfconf-query -c xfce4-power-manager -p /xfce4-power-manager/dpms-on-battery-off -s 0

xfce4_screensaver:
  cmd.run:
    - runas: "{{ pillar['user'] }}"
    - names:
      - xset s 1800
      - gsettings set org.gnome.desktop.screensaver lock-enabled false


