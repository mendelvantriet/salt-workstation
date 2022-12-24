firefox_esr_pkg:
  #  pkgrepo seems to be broken (https://github.com/saltstack/salt/issues/59065)
  cmd.run:
    - name: add-apt-repository ppa:mozillateam/ppa -y
    - unless: "grep -rq mozillateam/ppa /etc/apt/sources.list*"
  pkg.installed:
    - name: firefox-esr

firefox_esr_remove_firefox:
  pkg.removed:
    - name: firefox
    
/etc/firefox/policies.json:
  file.managed:
    - source: salt://firefox-esr/policies.json.tpl
    - template: jinja

/etc/firefox/syspref.js:
  file.managed:
    - source: salt://firefox-esr/syspref.js.tpl
    - template: jinja

