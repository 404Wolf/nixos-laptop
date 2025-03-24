{pkgs, ...}: {
  # Configure power button and lid switch actions
  services = {
    logind.powerKey = "lock";
    logind.powerKeyLongPress = "hibernate";
    logind.lidSwitch = "suspend-then-hibernate";
  };
  systemd.sleep.extraConfig = ''
    HibernateDelaySec=30M
    HibernateOnACPower=false
  '';

  # Disable kernel image protection to fix hibernation resume
  security.protectKernelImage = false;

  # Change power profile when on ac/battery
  services.udev.extraRules = let
    pluggedScript = pkgs.writeShellScript "power-plugged" ''
      mkdir -p /tmp/power-profiles

      ${pkgs.brightnessctl}/bin/brightnessctl set 100%
      ${pkgs.brightnessctl}/bin/brightnessctl -d 'framework_laptop::kbd_backlight' set 100%
      ${pkgs.power-profiles-daemon}/bin/powerprofilesctl set performance
    '';
    unpluggedScript =
      pkgs.writeShellScript "power-unplugged"
      # bash
      ''
        mkdir -p /tmp/power-profiles

        # Restore previous screen brightness if saved
        if [ -f /tmp/power-profiles/screen_brightness_plug ]; then
          saved_brightness=$(cat /tmp/power-profiles/screen_brightness_plug)
          if [ -n "$saved_brightness" ]; then
            ${pkgs.brightnessctl}/bin/brightnessctl set "$saved_brightness"
          else
            ${pkgs.brightnessctl}/bin/brightnessctl set 50%  # fallback value
          fi
          rm /tmp/power-profiles/screen_brightness_plug
        else
          ${pkgs.brightnessctl}/bin/brightnessctl set 50%  # fallback value
        fi

        # Restore previous keyboard backlight brightness if saved
        if [ -f /tmp/power-profiles/kbd_brightness_plug ]; then
          saved_kbd_brightness=$(cat /tmp/power-profiles/kbd_brightness_plug)
          if [ -n "$saved_kbd_brightness" ]; then
            ${pkgs.brightnessctl}/bin/brightnessctl -d 'framework_laptop::kbd_backlight' set "$saved_kbd_brightness"
          else
            ${pkgs.brightnessctl}/bin/brightnessctl -d 'framework_laptop::kbd_backlight' set 0%  # fallback value
          fi
          rm /tmp/power-profiles/kbd_brightness_plug
        else
          ${pkgs.brightnessctl}/bin/brightnessctl -d 'framework_laptop::kbd_backlight' set 0%  # fallback value
        fi

        ${pkgs.power-profiles-daemon}/bin/powerprofilesctl set power-saver
      '';
    saveBrightnessScript = pkgs.writeShellScript "save-brightness" ''
      mkdir -p /tmp/power-profiles

      ${pkgs.brightnessctl}/bin/brightnessctl get > /tmp/power-profiles/screen_brightness_plug
      ${pkgs.brightnessctl}/bin/brightnessctl -d 'framework_laptop::kbd_backlight' get > /tmp/power-profiles/kbd_brightness_plug
    '';
  in
    # Save brightness before plugging in
    ''
      ACTION=="change", SUBSYSTEM=="power_supply", ENV{POWER_SUPPLY_NAME}=="ACAD", ATTR{online}=="1", RUN+="${saveBrightnessScript}"
      ACTION=="change", SUBSYSTEM=="power_supply", ENV{POWER_SUPPLY_NAME}=="ACAD", ATTR{online}=="1", RUN+="${pluggedScript}"
      ACTION=="change", SUBSYSTEM=="power_supply", ENV{POWER_SUPPLY_NAME}=="ACAD", ATTR{online}=="0", RUN+="${unpluggedScript}"
    '' # fix keyboard autosuspend
    + ''
      ACTION=="add", SUBSYSTEM=="usb", ATTR{idVendor}=="0b05", ATTR{idProduct}=="1a96", ATTR{power/autosuspend}="-1", ATTR{power/control}="on"
      ACTION=="add", SUBSYSTEM=="usb", ATTR{idVendor}=="0853", ATTR{idProduct}=="0146", ATTR{power/autosuspend}="-1", ATTR{power/control}="on"
       ACTION=="add", SUBSYSTEM=="usb", ATTRS{idVendor}=="0853", ATTRS{idProduct}=="0146", ATTRS{manufacturer}=="Topre", ATTRS{product}=="REALFORCE 87 US", ATTR{power/autosuspend}="-1", ATTR{power/control}="on"
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

          brightness_reduced=0

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

            # Reset flag if battery is above 10% or if AC is connected
            if [ -n "$battery_level" ] && { [ "$battery_level" -gt 10 ] || [ "$ac_powered" -eq 1 ]; }; then
              brightness_reduced=0
            fi

            if [ -n "$battery_level" ] && [ "$battery_level" -eq 10 ] && [ "$ac_powered" -eq 0 ]; then
              if [ "$brightness_reduced" -eq 0 ]; then
                echo "Battery level is 10%, reducing brightness to 40%..."
                brightnessctl set 40%
                brightness_reduced=1
              fi
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
