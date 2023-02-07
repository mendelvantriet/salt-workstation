evolution-deps:
  pkg.installed:
    - pkgs:
      - evolution
      - evolution-plugin-bogofilter
      - evolution-ews

evolution-configuration:
  file.managed:
    - name: /home/{{ pillar.user }}/bin/evolution-backup.sh
    - source: salt://evolution/evolution-backup.sh
    - user: "{{ pillar['user'] }}"
    - group: "{{ pillar['group'] }}"
    - mode: 700
    - requires:
      - pkg: evolution-deps

evolution-backup-restore:
  cmd.run:
    - name: /home/{{ pillar.user }}/bin/evolution-backup.sh -r {{ pillar.evolution.backup_dir }}
    - runas: "{{ pillar['user'] }}"
    - stateful: True

