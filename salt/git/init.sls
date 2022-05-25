git_packages:
  pkg.installed:
    - pkgs:
      - git

git_configuration:
  cmd.run:
    - runas: "{{ pillar['user'] }}"
    - names:
      - git config --global user.email "{{ pillar['email'] }}"
      - git config --global user.name "{{ pillar['fullname'] }}"

/home/{{ pillar['user'] }}/.gitignore-system:
  file.managed:
    - source: salt://git/gitignore-system
    - user: "{{ pillar['user'] }}"
    - group: "{{ pillar['group'] }}"
    - mode: 600

git_generate_ssh_key:
  cmd.run:
    - runas: "{{ pillar['user'] }}"
    - name: ssh-keygen -q -N '' -f /home/{{ pillar['user'] }}/.ssh/id_rsa
    - creates: /home/{{ pillar['user'] }}/.ssh/id_rsa

git_add_ssh_key_to_agent:
  cmd.run:
    - runas: "{{ pillar['user'] }}"
    - names:
      - eval "$(ssh-agent -s)"
      - ssh-add ~/.ssh/id_rsa
    - onchanges:
      - cmd: git_generate_ssh_key

{% set key = salt['cmd.shell']('cat ~/.ssh/id_rsa.pub') %}

git_push_key:
  cmd.run:
    - runas: "{{ pillar['user'] }}"
    - name: curl -X POST -H "Accept:application/vnd.github.v3+json" -u "{{ pillar['git']['github']['username'] }}:{{ pillar['git']['github']['token'] }}" https://api.github.com/user/keys -d '{"title":"{{ pillar['git']['github']['key_title'] }}", "key":"{{ key }}"}'
    - onchanges:
      - cmd: git_generate_ssh_key


