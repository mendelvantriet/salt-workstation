<settings>
  <servers>

    {% for server in pillar['maven']['servers'] %}
    {% set password = salt['cmd.shell']('mvn --encrypt-password ' + server.password) -%}
    <server>
      <id>{{ server.id }}</id>
      <username>{{ server.username }}</username>
      <password>{{ password }}</password>
      <!-- other optional elements:
        <privateKey>/path/to/identity</privateKey> (default is ~/.ssh/id_dsa)
        <passphrase>my_key_passphrase</passphrase>
      -->
    </server>
    {% endfor %}

  </servers>

  <mirrors>
  
    {% for mirror in pillar['maven']['registry_mirrors'] %}
    <mirror>
      <id>{{ mirror.id }}</id>
      <name>{{ mirror.name }}</name>
      <url>{{ mirror.url }}</url>
      <mirrorOf>{{ mirror.mirror_of }}</mirrorOf>
    </mirror>
    {% endfor %}
    
  </mirrors>
</settings>
