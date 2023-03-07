autofs-deps:
  pkg.installed:
    - pkgs:
      - cifs-utils
      - autofs

autofs-configure-master:
  file.append:
    - name: /etc/auto.master
    - text: /media /etc/auto.media --browse

autofs-configure-media:
  file.managed:
    - name: /etc/auto.media
    - source: salt://mounts/auto.media
    - template: jinja

