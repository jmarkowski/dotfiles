#!/usr/bin/env bash
# Set HDMI3 as the secondary monitor in portrait orientation (rotated 90°
# clockwise), positioned to the right of HDMI2
xrandr \
  --output HDMI2 --rotate normal --primary --mode 1920x1080 \
  --output HDMI3 --rotate right --noprimary --mode 1920x1080 --right-of HDMI2

# xcompmgr is a compositing manager - it enables visual effects like shadows,
# transparency and fading. The & runs it in the background so the script
# continues immediately rather than waiting for it to exit.
# Start only if not already running
pgrep -x xcompmgr > /dev/null || xcompmgr &

# Restore the wallpaper using nitrogen's saved configuration. Runs after
# xrandr so it can paint the wallpaper correctly across both monitors.
#nitrogen --restore &
