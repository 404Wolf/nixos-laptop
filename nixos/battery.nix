{pkgs, ...}: {
  # Enable thermald for thermal management
  services.thermald.enable = true;

  # Set hyprlock as the resume command after sleep/suspend
  powerManagement.resumeCommands = "${pkgs.hyprlock}/bin/hyprlock";
  powerManagement.enable = true;

  # Configure power button and lid switch actions
  services = {
    logind.powerKey = "lock";
    logind.powerKeyLongPress = "hibernate";
    logind.lidSwitch = "suspend";
  };

  # Disable kernel image protection to fix hibernation resume
  security.protectKernelImage = false;

  # Additional logind configuration
  services.logind = {
    extraConfig = ''
      # Set power button to suspend then hibernate
      HandlePowerKey=suspend-then-hibernate
      # Set idle action to suspend then hibernate
      IdleAction=suspend-then-hibernate
      # Set idle timeout to 30 minutes
      IdleActionSec=30min
    '';
  };

  systemd.services.battery-hibernate = {
    description = "Hibernate on low battery";
    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.writeShellApplication {
        name = "battery-hibernate";
        runtimeInputs = with pkgs; [acpi systemd];
        text = ''
          while true; do
            battery_level=$(acpi -b | grep -P -o '[0-9]+(?=%)')
            ac_powered=$(acpi -a | grep -c "on-line")
            if [ "$battery_level" -le 2 ] && [ "$ac_powered" -eq 0 ]; then
              systemctl hibernate
            fi
            sleep 60
          done
        '';
      }}/bin/battery-hibernate";
    };
    wantedBy = ["multi-user.target"];
  };
}
