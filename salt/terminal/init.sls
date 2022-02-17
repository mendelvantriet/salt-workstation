terminal_packages:
  pkg.installed:
    - pkgs:
      - xfce4-terminal

terminal_configure:
  file.managed:
    - name: ~/.config/xfce4/terminal/terminalrc
    - source: salt://terminal/terminalrc
    - user: "{{ pillar['user'] }}"
    - group: "{{ pillar['group'] }}"
    - makedirs: True

