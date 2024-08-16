xfce4-remove-unwanted:
  pkg.removed:
    - pkgs:
      - mousepad
      - thunderbird

xfce4_default_apps:
  file.managed:
    - name: ~/.config/xfce4/helpers.rc
    - source: salt://xfce4/helpers.rc
    - user: "{{ pillar['user'] }}"
    - group: "{{ pillar['group'] }}"
    - makedirs: True

xfce4-custom-file-manager:
  file.managed:
    - name: ~/.local/share/xfce4/helpers/custom-FileManager.desktop
    - source: salt://xfce4/custom-FileManager.desktop
    - user: "{{ pillar['user'] }}"
    - group: "{{ pillar['group'] }}"
    - makedirs: True

xfce4-custom-web-browser:
  file.managed:
    - name: ~/.local/share/xfce4/helpers/custom-WebBrowser.desktop
    - source: salt://xfce4/custom-WebBrowser.desktop
    - user: "{{ pillar['user'] }}"
    - group: "{{ pillar['group'] }}"
    - makedirs: True

/home/{{ pillar.user }}/bin/xfce4_settings.sh:
  file.managed:
    - source: salt://xfce4/xfce4_settings.sh
    - template: jinja
    - user: "{{ pillar['user'] }}"
    - group: "{{ pillar['group'] }}"
    - mode: 755
    - makedirs: True

xfce4-settings:
  cmd.run:
    - name: exec /home/{{ pillar.user }}/bin/xfce4_settings.sh
    - runas: "{{ pillar['user'] }}"
    - onchanges: 
      - /home/{{ pillar.user }}/bin/xfce4_settings.sh

