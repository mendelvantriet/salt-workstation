ca-certificates:
  pkg.installed

/usr/local/share/ca-certificates:
  file.directory:
    - user: root
    - group: root
    - file_mode: 644
    - dir_mode: 755
    - makedirs: True
    - force: True
    - recurse:
      - user
      - group
      - mode

{% if salt.file.directory_exists(pillar['certificates']['path']) %}

  {% for file in salt.file.find(pillar['certificates']['path'], type='f', print='path') %}
{{ file }}:
  file.managed:
    - name: "/usr/local/share/ca-certificates/{{ file | replace(pillar['certificates']['path'], '') }}"
    - source: "{{ file }}"
    - makedirs: True
    - dir_mode: 755
    - mode: 644
    - force: True
    - subdir: True
  {% endfor %}

{% else %}

certificates_notification:
  test.configurable_test_state:
    - name: notification
    - warnings: Directory {{ pillar['certificates']['path'] }} does not exist

{% endif %}

update_ca_certificates:
  cmd.run:
   - name: 'update-ca-certificates'
   - onchanges:
    {% for file in salt.file.find(pillar['certificates']['path'], type='f', print='path') %}
     - file: "/usr/local/share/ca-certificates/{{ file | replace(pillar['certificates']['path'], '') }}"
    {% endfor %}
   - require:
     - pkg: ca-certificates

