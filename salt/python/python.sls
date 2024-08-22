python-deps:
  pkg.installed:
    - pkgs:
      - pipx

pipx-virtualenv:
  cmd.run:
    - name: "pipx install virtualenv"
    - runas: "{{ pillar['user'] }}"
    - unless:
      - pipx list --short -q | grep "virtualenv "
    - require:
      - pkg: python-deps

