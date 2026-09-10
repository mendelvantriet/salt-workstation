/home/{{ pillar['user'] }}/.config/gtk-3.0/bookmarks:
  file.managed:
    - source: salt://nemo/bookmarks.tpl
    - user: "{{ pillar['user'] }}"
    - group: "{{ pillar['group'] }}"
    - template: jinja
    - makedirs: True

