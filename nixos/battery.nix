{pkgs, ...}: {
  # Configure power button and lid switch actions
  services = {
    logind.powerKey = "lock";
    logind.powerKeyLongPress = "hibernate";
    logind.lidSwitch = "suspend";
  };

  # Disable kernel image protection to fix hibernation resume
  security.protectKernelImage = false;

  # Change power profile when on ac/battery
  services.udev.extraRules = let
    powerScript = pkgs.writeShellScript "power-state-changed" ''
      if [ $(cat /sys/class/power_supply/ACAD/online) -eq 1 ]; then
        ${pkgs.brightnessctl}/bin/brightnessctl set 100%
        powerprofilesctl set performance
      else
        ${pkgs.brightnessctl}/bin/brightnessctl set 65%
        powerprofilesctl set power-saver
      fi
    '';
  in ''
    SUBSYSTEM=="power_supply", ATTR{online}=="[01]", RUN+="${powerScript}"
  '';

  powerManagement = {
    enable = true;
    powertop.enable = true;
  };

  services = {
    tlp.enable = false;
    thermald.enable = true;
    power-profiles-daemon.enable = true;
    system76-scheduler = {
      enable = true;
      useStockConfig = true;
    };
  };

  # Various actions based on battery state
  systemd.services.low-battery-actions = {
    description = "Run actions based on on low battery";
    serviceConfig = {
      Type = "exec";
      Restart = "always";
      RestartSec = "60";
      ExecStart = "${pkgs.writeShellApplication {
        name = "low-battery-actions";
        runtimeInputs = with pkgs; [acpi systemd brightnessctl];
        text = ''
          set -euo pipefail

          while true; do
            # Check if acpi command succeeded
            if ! battery_info=$(acpi -b); then
              echo "Failed to get battery info"
              exit 1
            fi

            # Check if we can get AC power info
            if ! ac_info=$(acpi -a); then
              echo "Failed to get AC power info"
              exit 1
            fi

            # Extract battery level
            if ! battery_level=$(echo "$battery_info" | grep -P -o '[0-9]+(?=%)' || echo ""); then
              echo "Failed to parse battery level"
              exit 1
            fi

            # Extract AC power status
            ac_powered=$(echo "$ac_info" | grep -c "on-line" || true)

            echo "Battery level: $battery_level%, AC power: $ac_powered"

            if [ -n "$battery_level" ] && [ "$battery_level" -eq 10 ] && [ "$ac_powered" -eq 0 ]; then
              echo "Battery level is 10%, reducing brightness to 40%..."
              brightnessctl set 40%
            fi

            if [ -n "$battery_level" ] && [ "$battery_level" -le 2 ] && [ "$ac_powered" -eq 0 ]; then
              echo "Battery level is $battery_level%, hibernating..."
              systemctl hibernate
            fi

            sleep 30
          done
        '';
      }}/bin/low-battery-actions";
    };
    wantedBy = ["multi-user.target"];
  };
}
