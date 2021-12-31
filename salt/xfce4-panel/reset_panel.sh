#!/bin/bash

set -o errexit
set -o nounset
set -o pipefail

# reset plugins
xfconf-query -c xfce4-panel -p /plugins -r -R

# define plugins
xfconf-query -c xfce4-panel -p /plugins/plugin-1 -t string -s whiskermenu -n
xfconf-query -c xfce4-panel -p /plugins/plugin-2 -t string -s separator -n
xfconf-query -c xfce4-panel -p /plugins/plugin-4 -t string -s tasklist -n
xfconf-query -c xfce4-panel -p /plugins/plugin-4/show-handle -t bool -s false -n
xfconf-query -c xfce4-panel -p /plugins/plugin-5 -t string -s separator -n
xfconf-query -c xfce4-panel -p /plugins/plugin-5/expand -t bool -s true -n
xfconf-query -c xfce4-panel -p /plugins/plugin-5/style -t int -s 0 -n
xfconf-query -c xfce4-panel -p /plugins/plugin-6 -t string -s showdesktop -n
xfconf-query -c xfce4-panel -p /plugins/plugin-7 -t string -s pager -n
xfconf-query -c xfce4-panel -p /plugins/plugin-8 -t string -s systemload -n
xfconf-query -c xfce4-panel -p /plugins/plugin-9 -t string -s battery -n
xfconf-query -c xfce4-panel -p /plugins/plugin-10 -t string -s systray -n
xfconf-query -c xfce4-panel -p /plugins/plugin-11 -t string -s pulseaudio -n
xfconf-query -c xfce4-panel -p /plugins/plugin-12 -t string -s clock -n

# set plugin order
xfconf-query -c xfce4-panel -p /panels/panel-0/plugin-ids -a -n \
  -t int -s 1 -t int -s 2 \
  -t int -s 4 -t int -s 5 -t int -s 6 \
  -t int -s 7 -t int -s 8 -t int -s 9 \
  -t int -s 10 -t int -s 11 -t int -s 12

xfconf-query -c xfwm4 -p /general/workspace_count -t int -s 2 -n

# restart panel
xfce4-panel --restart

echo "changed=yes comment='xfce4-panel was reset'"

