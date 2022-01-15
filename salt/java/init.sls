java_packages:
  pkg.installed:
    - pkgs:
      - openjdk-8-jdk
      - sbt

maven:
  pkg.installed: []
  file.managed:
    - name: ~/.m2/settings-security.xml
    - user: "{{ pillar['user'] }}"
    - group: "{{ pillar['group'] }}"
    - mode: 600
    - source: salt://java/settings-security.xml.tpl
    - template: jinja
    - makedirs: True
    - require:
      - pkg: maven

maven_settings:
  file.managed:
    - name: ~/.m2/settings.xml
    - user: "{{ pillar['user'] }}"
    - group: "{{ pillar['group'] }}"
    - source: salt://java/settings.xml.tpl
    - template: jinja
    - makedirs: True
    - require:
      - pkg: maven
      - file: ~/.m2/settings-security.xml

