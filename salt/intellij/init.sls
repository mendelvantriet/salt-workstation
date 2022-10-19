{% if pillar['intellij']['version'] %}

{% set installation_base = "/home/" ~ pillar.user ~ "/apps" %}
{% set intellij_directory = installation_base ~ "/idea-IC-" ~ pillar.intellij.build %}
{% set intellij_home = installation_base ~ "/idea" %}

intellij_install:
  archive.extracted:
    - name: {{ installation_base }}
    - source: https://download.jetbrains.com/idea/ideaIC-{{ pillar['intellij']['version'] }}.tar.gz
    - source_hash: https://download.jetbrains.com/idea/ideaIC-{{ pillar['intellij']['version'] }}.tar.gz.sha256
    - enforce_toplevel: False
    - user: {{ pillar.user }}
    - group: {{ pillar.group }}
    - if_missing: {{ intellij_directory }}
  file.symlink:
    - name: {{ intellij_home }}
    - target: {{ intellij_directory }}
    - force: True
    - user: {{ pillar.user }}
    - group: {{ pillar.group }}

~/bin/idea.sh:
  file.symlink:
    - target: {{ intellij_home }}/bin/idea.sh
    - user: {{ pillar.user }}
    - group: {{ pillar.group }}

{% for plugin in pillar['intellij']['plugins'] %}
intellij_plugin_{{ plugin.name }}:
  archive.extracted:
    - name: {{ intellij_home }}/plugins/
    - source: {{ plugin.url }}
    - archive_format: zip
    - skip_verify: True
    - user: {{ pillar.user }}
    - group: {{ pillar.group }}
    - if_missing: {{ intellij_home }}/plugins/{{ plugin.name }}
{% endfor %}

~/.local/share/applications/IntelliJ.desktop:
  file.managed:
    - source: salt://intellij/IntelliJ.desktop.tpl
    - template: jinja
    - user: {{ pillar.user }}
    - group: {{ pillar.group }}
    - mode: 755
    - makedirs: True
    - context:
      intellij_home: {{ intellij_home }}
  
{% endif %}
