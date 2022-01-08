k8s_kubectl:
  cmd.run:
    - name: snap install kubectl --classic
    - unless: kubectl version --client=true
    - onlyif: snap version

k8s_helm:
  cmd.run:
    - name: snap install helm --classic
    - unless: helm version
    - onlyif: snap version

k8s_kind:
  file.managed:
    - name: /usr/local/bin/kind
    - source: https://kind.sigs.k8s.io/dl/v0.11.1/kind-linux-amd64
    - skip_verify: True
    - user: {{ pillar['user'] }}
    - group: {{ pillar['user'] }}
    - mode: 755

