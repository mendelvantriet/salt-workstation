#!/bin/bash

set -o errexit
set -o nounset
set -o pipefail

xfconf-query -c xfce4-power-manager -p /xfce4-power-manager/blank-on-ac -s 20
xfconf-query -c xfce4-power-manager -p /xfce4-power-manager/blank-on-battery -s 20
xfconf-query -c xfce4-power-manager -p /xfce4-power-manager/dpms-enabled -s false
xfconf-query -c xfce4-power-manager -p /xfce4-power-manager/dpms-on-ac-off -s 0
xfconf-query -c xfce4-power-manager -p /xfce4-power-manager/dpms-on-battery-off -s 0

xfconf-query -c xfce4-screensaver -p /lock/saver-activation/delay -t int -s 5 -n
xfconf-query -c xfce4-screensaver -p /saver/fullscreen-inhibit -t bool -s true -n

xfconf-query -c xfce4-keyboard-shortcuts -p "/xfwm4/custom/<Super>KP_Down" -s tile_down_key
xfconf-query -c xfce4-keyboard-shortcuts -p "/xfwm4/custom/<Super>KP_End" -s tile_down_left_key
xfconf-query -c xfce4-keyboard-shortcuts -p "/xfwm4/custom/<Super>KP_Home" -s tile_up_left_key
xfconf-query -c xfce4-keyboard-shortcuts -p "/xfwm4/custom/<Super>KP_Left" -s tile_left_key
xfconf-query -c xfce4-keyboard-shortcuts -p "/xfwm4/custom/<Super>KP_Next" -s tile_down_right_key
xfconf-query -c xfce4-keyboard-shortcuts -p "/xfwm4/custom/<Super>KP_Page_Up" -s tile_up_right_key
xfconf-query -c xfce4-keyboard-shortcuts -p "/xfwm4/custom/<Super>KP_Right" -s tile_right_key
xfconf-query -c xfce4-keyboard-shortcuts -p "/xfwm4/custom/<Super>KP_Up" -s tile_up_key

xfconf-query -c xfwm4 -p /general/theme -s "{{ pillar.xfce4.theme }}"
xfconf-query -c xsettings -p /Net/ThemeName -s "{{ pillar.xfce4.style }}"

echo "changed=yes comment='xfce4 settings changed'"

