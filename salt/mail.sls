mail_packages:
  pkg.installed:
    - pkgs:
      - evolution
      - evolution-plugin-bogofilter
      - evolution-ews

{% if pillar['mail']['restore_config'] %}
  {% if salt.file.directory_exists(pillar['mail']['config_dir_path']) %}

mail_configuration:
  file.copy:
    - name: ~/.config/evolution
    - source: {{ pillar['mail']['config_dir_path'] }}
    - recurse: True
    - user: {{ pillar['user'] }}
    - group: {{ pillar['group'] }}
    - mode: 700
    - force: pillar['mail']['replace_config']

  {% else %}

mail_notification:
  test.configurable_test_state:
    - name: notification
    - warnings: Directory {{ pillar['mail']['config_dir_path'] }} does not exist

  {% endif %}
{% endif %}

