#!/usr/bin/env bash
# X compositing manager to enable basic eye-candy effects
xcompmgr

# Swap the monitors
xrandr --output DP1 --rotate normal --primary --mode 1920x1080
xrandr --output DP2 --rotate right --noprimary --mode 1920x1080 --right-of DP1
