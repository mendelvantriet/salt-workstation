helm:
  cmd.run:
    - name: snap install helm --classic
    - unless: helm version
    - onlyif: snap version

