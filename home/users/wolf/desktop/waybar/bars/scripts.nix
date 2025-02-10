{pkgs, ...}: {
  toggleCpuGovernor = pkgs.writeShellScript "cpu-governor-toggle" ''
    current_profile=$(powerprofilesctl get)

    case "$current_profile" in
      performance)
        powerprofilesctl set balanced
        ;;
      balanced)
        powerprofilesctl set power-saver
        ;;
      power-saver)
        powerprofilesctl set performance
        ;;
      *)
        powerprofilesctl set balanced
        ;;
    esac

    kill -SIGRTMIN+1 $(pgrep waybar) # reload waybar
  '';

  getCpuGovernor = pkgs.writeShellScript "cpu-governor-check" ''
    current_profile=$(powerprofilesctl get)

    case "$current_profile" in
      performance)
        echo '{"text": "󰓅", "tooltip": "Performance Mode"}'
        ;;
      balanced)
        echo '{"text": "󰗑", "tooltip": "Balanced Mode"}'
        ;;
      power-saver)
        echo '{"text": "󰾆", "tooltip": "Power Saver Mode"}'
        ;;
      *)
        echo '{"text": "?", "tooltip": "Unknown Mode"}'
        ;;
    esac
  '';
}
