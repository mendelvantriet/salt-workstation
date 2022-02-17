{% for app in pillar['autostart']['apps'] %}

~/.config/autostart/{{ app.name }}.desktop:
  file.managed:
    - source: salt://autostart/app.desktop.tpl
    - makedirs: True
    - user: "{{ pillar['user'] }}"
    - group: "{{ pillar['group'] }}"
    - template: jinja
    - context:
        app: {{ app }}

{% endfor %}

