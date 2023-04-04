filezilla-deps:
  pkg.installed:
    - pkgs:
      - filezilla

filezilla-sitemanager:
  file.managed:
    - name: /home/{{ pillar.user }}/.config/filezilla/sitemanager.xml
    - source: salt://filezilla/sitemanager.xml.tpl
    - user: "{{ pillar.user }}"
    - group: "{{ pillar.group }}"
    - mode: 600
    - template: jinja
    - makedirs: True
    - requires:
      - pkg: filezilla-deps

