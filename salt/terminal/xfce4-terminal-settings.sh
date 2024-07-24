#!/bin/bash

set -o errexit
set -o nounset
set -o pipefail

xfconf-query -c xfce4-terminal -p /scrolling-unlimited -t bool -s true -n
xfconf-query -c xfce4-terminal -p /misc-default-geometry -t string -s 120x40 -n

echo "changed=yes comment='xfce4-terminal settings changed'"

