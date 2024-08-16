firefox-esr-remove-existing:
  pkg.removed:
    - name: firefox
  cmd.run:
    - name: "snap remove --purge firefox"
    - onlyif: "snap list firefox"

firefox-esr-deps:
  pkg.installed:
    - pkgs:
      - libc6 # glibc
      - libgtk-3-dev # gtk3+
      - libglib2.0-dev # glib
      - libstdc++6 # libstdc++
      - xorg
      - dbus
      - network-manager
      - pulseaudio

firefox-esr-install:
  #  pkgrepo seems to be broken (https://github.com/saltstack/salt/issues/59065)
  cmd.run:
    - name: add-apt-repository ppa:mozillateam/ppa -y
    - unless: "grep -rq mozillateam/ppa /etc/apt/sources.list*"
  pkg.installed:
    - name: firefox-esr

/etc/firefox-esr/policies/policies.json:
  file.managed:
    - source: salt://firefox-esr/policies.json.tpl
    - template: jinja
    - makedirs: True

/etc/firefox-esr/syspref.js:
  file.managed:
    - source: salt://firefox-esr/syspref.js.tpl
    - template: jinja
    - makedirs: True

