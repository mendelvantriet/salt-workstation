{% if pillar.latex.dependencies %}
latex_dependencies:
  pkg.installed:
    - pkgs:
      {% for d in pillar.latex.dependencies %}
      - {{ d }}
      {% endfor %}
{% endif %}

{% set download_dir = "/home/" ~ pillar['user'] ~ "/Downloads" %}
{% set extracted_dir = download_dir ~ "/texlive-" ~ pillar.latex.version %}
{% set texlive_profile = extracted_dir ~ "/texlive.profile" %}
{% set path = pillar.latex.installation_dir.replace('~', '$HOME') ~ '/' ~ pillar.latex.version ~ '/bin/' ~ pillar.latex.architecture ~ '-linux' %}

{{ extracted_dir }}:
  file.directory:
    - user: "{{ pillar['user'] }}"
    - group: "{{ pillar['group'] }}"
  
latex_install:
  archive.extracted:
    - name: {{ download_dir }}/
    - source: https://mirror.ctan.org/systems/texlive/tlnet/install-tl-unx.tar.gz
    - skip_verify: True
    - archive_format: tar
    - options: --strip-components 1 -C {{ extracted_dir }}
    - enforce_toplevel: False
    - runas: "{{ pillar.user }}"
    - if_missing: {{ extracted_dir }}/install-tl }}
    - unless: test -d {{ extracted_dir }}/install-tl }}
  file.managed:
    - name: {{ texlive_profile }}
    - user: "{{ pillar['user'] }}"
    - group: "{{ pillar['group'] }}"
    - mode: 600
    - source: salt://latex/texlive.profile
    - template: jinja
  cmd.run:
    - name: {{ extracted_dir }}/install-tl --no-gui --profile={{ texlive_profile }} --repository={{ pillar.latex.mirror }}
    - runas: {{ pillar.user }}
    - unless: test -d {{ pillar.latex.installation_dir }}/{{ pillar.latex.version }}

latex_path:
  file.append:
    - name: {{ pillar.rc_file }}
    - text: |
        if [ -d "{{ path }}" ] ; then 
          export PATH="{{ path }}:$PATH"
        fi

latex_init:
  cmd.run:
    - names:
      - {{ path }}/tlmgr init-usertree
      - {{ path }}/tlmgr option repository {{ pillar.latex.mirror }}
    - runas: {{ pillar.user }}
    - unless: "test -f /home/{{ pillar['user'] }}/texmf/tlpkg/texlive.tlpdb"

{% if pillar.latex.packages %}
tlmgr_packages:
  cmd.run:
    - names:
      - {{ path }}/tlmgr option repository {{ pillar.latex.mirror }}
      {% for p in pillar.latex.packages %}
      - {{ path }}/tlmgr install {{ p }}
      {% endfor %}
    - runas: {{ pillar.user }}
{% endif %}

