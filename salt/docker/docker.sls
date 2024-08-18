docker_packages:
  pkg.installed:
    - pkgs:
      - docker.io
      - docker-compose-v2

docker_group_membership:
  user.present:
    - name: "{{ pillar['user'] }}"
    - groups: ["docker"]
    - remove_groups: False

docker_config:
  file.managed:
    - name: /home/{{ pillar['user'] }}/.docker/config.json
    - user: "{{ pillar['user'] }}"
    - group: "{{ pillar['group'] }}"
    - mode: 600
    - makedirs: True
    - source: salt://docker/config.json.tpl
    - template: jinja

docker_configure_daemon:
  file.managed:
    - name: /etc/docker/daemon.json
    - source: salt://docker/daemon.json.tpl
    - template: jinja

docker:
  service.running:
    - enable: True
    - watch:
      - file: /etc/docker/daemon.json

