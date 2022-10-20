{% macro ssh_keygen(user, key_name) %}

ssh-keygen_{{ key_name }}:
  cmd.run:
    - runas: "{{ user }}"
    - name: ssh-keygen -q -N '' -f {{ key_name }} -C ''
    - creates: {{ key_name }}

ssh-add_{{ key_name }}:
  cmd.run:
    - runas: "{{ user }}"
    - names:
      - eval "$(ssh-agent -s)"
      - ssh-add {{ key_name }}

{% endmacro %}

