xfce4-panel-deps:
  pkg.installed:
    - pkgs:
      - clipman
      - xfce4-battery-plugin
      - xfce4-systemload-plugin
      - xfce4-whiskermenu-plugin

xfce4-panel-reset:
  cmd.script:
    - runas: "{{ pillar['user'] }}"
    - source: salt://xfce4-panel/reset_panel.sh

