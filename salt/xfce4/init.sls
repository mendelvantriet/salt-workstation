xfce4_default_apps:
  file.managed:
    - name: ~/.config/xfce4/helpers.rc
    - source: salt://xfce4/helpers.rc
    - user: "{{ pillar['user'] }}"
    - group: "{{ pillar['group'] }}"
    - makedirs: True

xfce4_custom_file_manager:
  file.managed:
    - name: ~/.local/share/xfce4/custom-FileManager.desktop
    - source: salt://xfce4/custom-FileManager.desktop
    - user: "{{ pillar['user'] }}"
    - group: "{{ pillar['group'] }}"
    - makedirs: True

/home/{{ pillar.user }}/bin/xfce4_settings.sh:
  file.managed:
    - source: salt://xfce4/xfce4_settings.sh
    - user: "{{ pillar['user'] }}"
    - group: "{{ pillar['group'] }}"
    - mode: 755
    - makedirs: True

xfce4_settings:
  cmd.run:
    - name: exec /home/{{ pillar.user }}/bin/xfce4_settings.sh
    - runas: "{{ pillar['user'] }}"
    - onchanges: 
      - /home/{{ pillar.user }}/bin/xfce4_settings.sh

