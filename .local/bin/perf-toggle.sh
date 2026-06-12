#!/bin/sh
# Toggle expensive eye-candy (blur/shadow/animations) for battery / max-FPS.
# CPU governor is already managed by TLP per AC/BAT.
STATE="${XDG_RUNTIME_DIR:-/tmp}/perf_mode"
if [ -f "$STATE" ]; then
    hyprctl keyword decoration:blur:enabled true
    hyprctl keyword decoration:shadow:enabled true
    hyprctl keyword animations:enabled true
    rm -f "$STATE"
    notify-send -t 2000 "Pretty mode" "Blur, shadows & animations ON"
else
    hyprctl keyword decoration:blur:enabled false
    hyprctl keyword decoration:shadow:enabled false
    hyprctl keyword animations:enabled false
    touch "$STATE"
    notify-send -t 2000 "Performance mode" "Effects OFF - max FPS / battery"
fi
