git-deps:
  pkg.installed:
    - pkgs:
      - git
      - curl

git_configuration:
  cmd.run:
    - runas: "{{ pillar['user'] }}"
    - names:
      - git config --global user.email "{{ pillar['email'] }}"
      - git config --global user.name "{{ pillar['fullname'] }}"
    - requires:
      - pkg: git-deps

/home/{{ pillar['user'] }}/.gitignore-system:
  file.managed:
    - source: salt://git/gitignore-system
    - user: "{{ pillar['user'] }}"
    - group: "{{ pillar['group'] }}"
    - mode: 600

{% for account in pillar.git.github_accounts %}
  {% set key_filename = '/home/' ~ pillar.user ~ '/.ssh/id_rsa.' ~ account.username ~ '@github' %}

  {% from 'lib.sls' import ssh_keygen with context %}
  {{ ssh_keygen(pillar.user, key_filename) }}

git_push_key_{{ key_filename }}:
  github.add_ssh_key:
    - name: {{ key_filename }}.pub
    - title: {{ account.key_title }}
    - token: {{ account.token }}

{% endfor %}

