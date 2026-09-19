kubectl:
  cmd.run:
    - name: snap install kubectl --classic
    - unless: kubectl version --client=true
    - onlyif: snap version

