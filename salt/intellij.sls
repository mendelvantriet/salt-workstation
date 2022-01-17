{% if pillar['intellij']['version'] %}

intellij_install:
  archive.extracted:
    - name: /opt
    - source: https://download.jetbrains.com/idea/ideaIC-{{ pillar['intellij']['version'] }}.tar.gz
    - source_hash: https://download.jetbrains.com/idea/ideaIC-{{ pillar['intellij']['version'] }}.tar.gz.sha256
    - if_missing: /opt/idea-IC-{{ pillar['intellij']['build'] }}

/opt/idea:
  file.symlink:
    - target: /opt/idea-IC-{{ pillar['intellij']['build'] }}

/usr/local/bin/idea.sh:
  file.symlink:
    - target: /opt/idea/bin/idea.sh

{% for plugin in pillar['intellij']['plugins'] %}
intellij_plugin_{{ plugin.name }}:
  archive.extracted:
    - name: /opt/idea/plugins/
    - source: {{ plugin.url }}
    - archive_format: zip
    - skip_verify: True
    - if_missing: /opt/idea/plugins/{{ plugin.name }}
{% endfor %}

{% endif %}
