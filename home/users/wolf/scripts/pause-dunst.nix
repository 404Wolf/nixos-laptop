{pkgs}:
pkgs.writeShellScriptBin "toggle-dunst" #bash

''
  # Check the current state and display a message
  if dunstctl is-paused; then
      dunstctl set-paused toggle
      ${pkgs.libnotify}/bin/notify-send "Dunst Active" "Dunst notifications are now active"
  else
      ${pkgs.libnotify}/bin/notify-send "Dunst Do Not Disturb" "Notifications are now silenced"
      sleep 6
      dunstctl set-paused toggle
  fi
''
