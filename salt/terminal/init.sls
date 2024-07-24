terminal-deps:
  pkg.installed:
    - pkgs:
      - xfce4-terminal

/home/{{ pillar.user }}/bin/xfce4-terminal-settings.sh:
  file.managed:
    - source: salt://terminal/xfce4-terminal-settings.sh
    - template: jinja
    - user: "{{ pillar['user'] }}"
    - group: "{{ pillar['group'] }}"
    - mode: 755
    - makedirs: True

xfce4-terminal-settings:
  cmd.run:
    - name: exec /home/{{ pillar.user }}/bin/xfce4-terminal-settings.sh
    - runas: "{{ pillar['user'] }}"
    - onchanges: 
      - /home/{{ pillar.user }}/bin/xfce4-terminal-settings.sh

