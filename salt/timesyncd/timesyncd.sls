# https://ubuntu.com/server/docs/network-ntp

timesyncd-conf:
  file.replace:
    - name: /etc/systemd/timesyncd.conf
    - pattern: ^#?PollIntervalMaxSec=.*$
    - repl: "PollIntervalMaxSec={{ pillar.timesyncd.poll_interval_max_sec }}"

