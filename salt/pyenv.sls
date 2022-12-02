python-deps:
  pkg.installed:
    - pkgs:
      - python3-dev
      - libbz2-dev
      - liblzma-dev
      - libsqlite3-dev
      - libreadline-dev
      - libncurses-dev
      - tk-dev

# https://github.com/pyenv/pyenv#basic-github-checkout
pyenv-install:
  git.latest:
    - name: https://github.com/pyenv/pyenv.git
    - target: /home/{{ pillar['user'] }}/.pyenv
    - user: "{{ pillar['user'] }}"
    - rev: master
    - depth: 1

pyenv-init:
  file.append:
    - name: {{ pillar.rc_file }}
    - text: |
        ### START BLOCK pyenv ###
        export PYENV_ROOT="$HOME/.pyenv"
        command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
        ### END   BLOCK pyenv ###

