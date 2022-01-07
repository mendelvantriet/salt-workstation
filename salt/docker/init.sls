docker_packages:
  pkg.installed:
    - pkgs:
      - docker
      - docker-compose

docker_group_membership:
  user.present:
    - name: "{{ pillar['user'] }}"
    - groups: ["docker"]
    - remove_groups: False

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

