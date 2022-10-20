zsh_packages:
  pkg.installed:
    - pkgs:
      - git # required for oh_my_zsh
      - zsh

zsh_install_oh_my_zsh:
  git.latest:
    - name: https://github.com/ohmyzsh/ohmyzsh.git
    - target: /home/{{ pillar['user'] }}/.oh-my-zsh
    - user: "{{ pillar['user'] }}"
    - rev: master
    - depth: 1

zsh_configure_oh_my_zsh:
  cmd.run:
    - runas: "{{ pillar['user'] }}"
    - onlyif: 'test ! -e ~/.zshrc'
    - name: cp ~/.oh-my-zsh/templates/zshrc.zsh-template ~/.zshrc

zsh_change_shell:
  cmd.run:
    - name: chsh -s $(which zsh) {{ pillar.user }}

