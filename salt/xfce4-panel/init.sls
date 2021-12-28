xfce4_panel_packages:
  pkg.installed:
    - pkgs:
      - xfce4-battery-plugin
      - xfce4-systemload-plugin
      - xfce4-whiskermenu-plugin

xfce4_panel:
  cmd.script:
    - runas: "{{ pillar['user'] }}"
    - source: salt://xfce4-panel/reset_panel.sh

