awscli-v2-install:
  cmd.run:
    - name: snap install aws-cli --classic
    - unless: snap list aws-cli

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

