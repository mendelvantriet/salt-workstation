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

