autofs-deps:
  pkg.installed:
    - pkgs:
      - cifs-utils
      - autofs

autofs-configure-master:
  file.blockreplace:
    - name: /etc/auto.master
    - marker_start: "### START BLOCK maps ###"
    - marker_end:   "### END   BLOCK maps ###"
    - content: |
        /mnt /etc/auto.mnt --browse --timeout 7200
    - backup: '.bak'
    - append_if_not_found: True
    - append_newline: False
    - show_changes: True

autofs-configure-mnt:
  file.managed:
    - name: /etc/auto.mnt
    - source: salt://mounts/auto.mnt
    - template: jinja

