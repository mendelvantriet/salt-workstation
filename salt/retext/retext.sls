retext-deps:
  pkg.installed:
    - pkgs:
      - retext

~/.local/share/applications/retext.desktop:
  file.managed:
    - source: salt://retext/retext.desktop.tpl
    - template: jinja
    - user: {{ pillar.user }}
    - group: {{ pillar.group }}
    - mode: 755
    - makedirs: True

retext-file-association:
  file.replace:
    - name: /usr/share/applications/defaults.list
    - pattern: text/markdown=.*
    - repl: "text/markdown=retext.desktop"
    - append_if_not_found: True

