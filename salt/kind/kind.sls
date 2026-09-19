kind:
  file.managed:
    - name: /usr/local/bin/kind
    - source: https://kind.sigs.k8s.io/dl/v0.11.1/kind-linux-amd64
    - skip_verify: True
    - user: {{ pillar['user'] }}
    - group: {{ pillar['user'] }}
    - mode: 755

