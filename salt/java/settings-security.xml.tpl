<settingsSecurity>
  {% set master_password = salt['cmd.shell']('mvn --encrypt-master-password ' + pillar['maven']['master_password']) -%}
  <master>{{ master_password }}</master>
</settingsSecurity>
