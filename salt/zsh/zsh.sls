zsh-deps:
  pkg.installed:
    - pkgs:
      - git # required for oh_my_zsh
      - zsh

zsh-change_shell:
  cmd.run:
    - name: chsh -s $(which zsh) {{ pillar.user }}
    - unless: "test $SHELL = /usr/bin/zsh"

zsh-install-oh_my_zsh:
  git.latest:
    - name: https://github.com/ohmyzsh/ohmyzsh.git
    - target: /home/{{ pillar['user'] }}/.oh-my-zsh
    - user: "{{ pillar['user'] }}"
    - rev: master
    - depth: 1

zsh-configure-oh_my_zsh:
  cmd.run:
    - name: cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc
    - runas: "{{ pillar['user'] }}"
    - onlyif: 'test ! -e ~/.zshrc'

zsh-ohmyzsh-plugins:
  file.replace:
    - name: ~/.zshrc
    - pattern: plugins=.*
    - repl: "plugins=({{ pillar.zsh.plugins | join(' ') }})"

zsh-update-path:
  file.blockreplace:
    - name: {{ pillar.rc_file }}
    - runas: "{{ pillar.user }}"
    - marker_start: "### START BLOCK $HOME/.local/bin ###"
    - marker_end:   "### END   BLOCK $HOME/.local/bin ###"
    - content: |
        if ![[ ":$PATH:" == *":$HOME/.local/bin:"* ]]; then
          export PATH="$HOME/.local/bin:$PATH"
        fi
    - backup: '.bak'
    - append_if_not_found: True
    - append_newline: False
    - show_changes: True

