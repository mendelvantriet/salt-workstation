python3-pip:
  pkg.installed

awscli:
  pip.installed:
    - runas: "{{ pillar['user'] }}"
    - require:
      - pkg: python3-pip

~/.aws/config:
  file.managed:
    - user: "{{ pillar['user'] }}"
    - group: "{{ pillar['group'] }}"
    - source: salt://aws/config.tpl
    - template: jinja
    - makedirs: True

~/.aws/credentials:
  file.managed:
    - user: "{{ pillar['user'] }}"
    - group: "{{ pillar['group'] }}"
    - mode: 600
    - source: salt://aws/credentials.tpl
    - template: jinja
    - makedirs: True

