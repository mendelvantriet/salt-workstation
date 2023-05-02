python-deps:
  pkg.installed:
    - pkgs:
      - build-essential
      - libssl-dev
      - libffi-dev
      - python3-dev

pip-deps:
  pkg.installed:
    - pkgs:
      - python3-pip

pyenv-deps:  # https://github.com/pyenv/pyenv/wiki#suggested-build-environment
  pkg.installed:
    - pkgs:
      - build-essential
      - libssl-dev
      - zlib1g-dev
      - libbz2-dev
      - libreadline-dev
      - libsqlite3-dev
      - curl
      - libncursesw5-dev
      - xz-utils
      - tk-dev
      - libxml2-dev
      - libxmlsec1-dev
      - libffi-dev
      - liblzma-dev

virtualenv:
  pip.installed:
    - runas: "{{ pillar['user'] }}"
    - require:
      - pkg: pip-deps

{% for version in pillar.pyenv.versions %}
{{ version }}:
  pyenv.installed:
    - default: False
    - user: "{{ pillar.user }}"
    - require:
      - pkg: pyenv-deps
{% endfor %}

pyenv-init:
  file.blockreplace:
    - name: {{ pillar.rc_file }}
    - runas: "{{ pillar.user }}"
    - marker_start: "### START BLOCK pyenv ###"
    - marker_end:   "### END   BLOCK pyenv ###"
    - content: |
        export PYENV_ROOT="$HOME/.pyenv"
        command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
    - backup: '.bak'
    - append_if_not_found: True
    - append_newline: False
    - show_changes: True

