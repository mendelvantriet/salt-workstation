{% macro ssh_keygen(user, key_type, key_filename) %}

ssh-keygen_{{ key_filename }}:
  cmd.run:
    - runas: "{{ user }}"
    - name: ssh-keygen -t {{ type }} -q -N '' -f {{ key_filename }} -C ''
    - creates: {{ key_filename }}

{% endmacro %}

