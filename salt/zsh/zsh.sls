zsh-deps:
  pkg.installed:
    - pkgs:
      - git # required for oh_my_zsh
      - zsh

zsh-change_shell:
  cmd.run:
    - name: chsh -s $(which zsh) {{ pillar.user }}
    - unless: "test $SHELL = /usr/bin/zsh"

zsh_install_oh_my_zsh:
  git.latest:
    - name: https://github.com/ohmyzsh/ohmyzsh.git
    - target: /home/{{ pillar['user'] }}/.oh-my-zsh
    - user: "{{ pillar['user'] }}"
    - rev: master
    - depth: 1

zsh_configure_oh_my_zsh:
  cmd.run:
    - name: cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc
    - runas: "{{ pillar['user'] }}"
    - onlyif: 'test ! -e ~/.zshrc'

zsh-ohmyzsh-plugins:
  file.replace:
    - name: ~/.zshrc
    - pattern: plugins=.*
    - repl: "plugins=({{ pillar.zsh.plugins | join(' ') }})"

