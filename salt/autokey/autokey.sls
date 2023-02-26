autokey-deps:
  pkg.installed:
    - pkgs:
      - autokey-gtk

/home/{{ pillar['user'] }}/.config/autokey/data/scripts:
  file.recurse:
    - source: salt://autokey/scripts
    - user: "{{ pillar['user'] }}"
    - group: "{{ pillar['group'] }}"
    - file_mode: 644
    - dir_mode: 755

