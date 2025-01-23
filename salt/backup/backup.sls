backup-file:
  file.managed:
    - name: /home/{{ pillar.user }}/bin/backup-workstation.sh
    - source: salt://backup/backup-workstation.sh.tpl
    - template: jinja
    - user: "{{ pillar['user'] }}"
    - group: "{{ pillar['group'] }}"
    - mode: 755

{% if pillar.backup.location -%}

/home/{{ pillar.user }}/bin/backup-workstation.sh {{ pillar.backup.location }}:
  cron.present:
    - identifier: backup-workstation
    - user: {{ pillar.user }}
    - special: '@hourly'

{%- endif %}

