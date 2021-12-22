packages:
  pkg.installed:
    - pkgs:
      - apt-transport-https
      - curl
      - gcc
      - make
      - unzip
      - zip

debug:
  cmd.run:
    - names:
      - env

power_manager:
  cmd.run:
    - runas: "{{ pillar['user'] }}"
    - names:
      - xfconf-query -c xfce4-power-manager -p /xfce4-power-manager/blank-on-ac -s 20
      - xfconf-query -c xfce4-power-manager -p /xfce4-power-manager/blank-on-battery -s 20
      - xfconf-query -c xfce4-power-manager -p /xfce4-power-manager/dpms-enabled -s false
      - xfconf-query -c xfce4-power-manager -p /xfce4-power-manager/dpms-on-ac-off -s 0
      - xfconf-query -c xfce4-power-manager -p /xfce4-power-manager/dpms-on-battery-off -s 0

screensaver:
  cmd.run:
    - runas: "{{ pillar['user'] }}"
    - names:
      - xset s 1800
      - gsettings set org.gnome.desktop.screensaver lock-enabled false


include:
  - edit
  - file_browser
  - git
  - latex
  - mail
  - mounts
  - terminal
  - xfce4
  - zsh
  

