#!/usr/bin/env bash
# X compositing manager to enable basic eye-candy effects
xcompmgr

# Swap the monitors
xrandr --output DP1 --primary --rotate normal --right-of DP2 --panning 1920x1080+1080+540
xrandr --output DP2 --rotate right --panning 1080x1920+0+0
