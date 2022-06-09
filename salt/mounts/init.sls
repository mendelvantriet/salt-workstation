mounts_packages:
  pkg.installed:
    - pkgs:
      - cifs-utils
      - autofs

mounts_configure_master:
  file.append:
    - name: /etc/auto.master
    - text: /media /etc/auto.media --browse

mounts_configure_media:
  file.managed:
    - name: /etc/auto.media
    - source: salt://mounts/auto.media
    - template: jinja

