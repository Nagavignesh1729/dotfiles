#!/usr/bin/env python3
import subprocess, json
SEP = "\x1f"
fmt = "{{playerName}}" + SEP + "{{status}}" + SEP + "{{artist}} - {{title}}"
proc = subprocess.Popen(["playerctl", "--follow", "metadata", "--format", fmt],
                        stdout=subprocess.PIPE, text=True)
for raw in proc.stdout:
    parts = raw.rstrip("\n").split(SEP)
    if len(parts) != 3 or parts[1] not in ("Playing", "Paused"):
        print(json.dumps({"text": ""}), flush=True); continue
    player, status, info = parts
    info = info.strip(" -")
    if not info:
        print(json.dumps({"text": ""}), flush=True); continue
    print(json.dumps({"text": info, "alt": player.lower(),
                      "class": status.lower(), "tooltip": f"{info} ({player})"}), flush=True)
