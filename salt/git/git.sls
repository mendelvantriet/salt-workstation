git-deps:
  pkg.installed:
    - pkgs:
      - git
      - curl
      - git-filter-repo

/home/{{ pillar.user }}/git:
  file.directory:
    - user: {{ pillar.user }}
    - group: {{ pillar.group }}
    - mode: 700

git-configuration:
  file.managed:
    - name: /home/{{ pillar.user }}/.gitconfig
    - source: salt://git/gitconfig-global.tpl
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

{% for organization in pillar.git.organizations %}
  {% set key_type = 'ecdsa' %}
  {% set key_filename = '/home/' ~ pillar.user ~ '/.ssh/id_' ~ key_type ~ '.' ~ organization.name ~ '@' ~ organization.host %}

  {% from 'lib.sls' import ssh_keygen with context %}
  {{ ssh_keygen(pillar.user, key_type, key_filename) }}

/home/{{ pillar['user'] }}/git/{{ organization.name }}:
  file.directory:
    - user: "{{ pillar['user'] }}"
    - group: "{{ pillar['group'] }}"
    - dir_mode: 700

/home/{{ pillar['user'] }}/git/{{ organization.name }}/.gitconfig:
  file.managed:
    - source: salt://git/gitconfig-local.tpl
    - user: "{{ pillar['user'] }}"
    - group: "{{ pillar['group'] }}"
    - mode: 600
    - template: jinja
    - context:
        identityfile: {{ key_filename }}
    - requires:
      - pkg: git-deps

{% endfor %}


# Clone git repositories

{% for repo in pillar.git.repositories %}
{{ repo.url }}:
  git.cloned:
    - target: {{ repo.target }}
    - user: {{ pillar.user }}
    - require:
      - file: /home/{{ pillar.user }}/git
{% endfor %}

