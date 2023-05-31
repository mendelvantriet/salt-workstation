git-deps:
  pkg.installed:
    - pkgs:
      - git
      - curl
      - git-filter-repo

git-configuration:
  file.managed:
    - name: /home/{{ pillar.user }}/.gitconfig
    - source: salt://git/gitconfig.tpl
    - user: "{{ pillar['user'] }}"
    - group: "{{ pillar['group'] }}"
    - mode: 600
    - template: jinja
    - requires:
      - pkg: git-deps

/home/{{ pillar['user'] }}/.config/git:
  file.directory:
    - user: "{{ pillar['user'] }}"
    - group: "{{ pillar['group'] }}"
    - dir_mode: 700

/home/{{ pillar['user'] }}/.config/git/gitignore:
  file.managed:
    - source: salt://git/gitignore-global
    - user: "{{ pillar['user'] }}"
    - group: "{{ pillar['group'] }}"
    - mode: 600

{% for account in pillar.git.github_accounts %}
  {% set key_filename = '/home/' ~ pillar.user ~ '/.ssh/id_rsa.' ~ account.username ~ '@github' %}

  {% from 'lib.sls' import ssh_keygen with context %}
  {{ ssh_keygen(pillar.user, key_filename) }}

git-host-{{ account.host }}:
  file.blockreplace:
    - name: ~/.ssh/config
    - runas: "{{ pillar.user }}"
    - marker_start: "### START BLOCK {{ account.host }} ###"
    - marker_end:   "### END   BLOCK {{ account.host }} ###"
    - template: jinja
    - source: salt://git/ssh_config.block.tpl
    - backup: '.bak'
    - append_if_not_found: True
    - append_newline: False
    - show_changes: True
    - context:
        host: {{ account.host }}
        hostname: github.com
        user: git
        identityfile: {{ key_filename }}
    - onlyif: 'touch ~/.ssh/config' 

git_push_key_{{ key_filename }}:
  github.add_ssh_key:
    - name: {{ key_filename }}.pub
    - title: {{ account.key_title }}
    - token: {{ account.token }}

{% endfor %}


# Clone git repositories

/home/{{ pillar.user }}/git:
  file.directory:
    - user: {{ pillar.user }}
    - group: {{ pillar.group }}
    - mode: 700

{% for repo in pillar.git.repositories %}
{{ repo.url }}:
  git.cloned:
    - target: {{ repo.target }}
    - user: {{ pillar.user }}
    - require:
      - file: /home/{{ pillar.user }}/git
{% endfor %}

