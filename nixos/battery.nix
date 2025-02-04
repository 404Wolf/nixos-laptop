{pkgs, ...}: {
  # Enable thermald for thermal management
  services.thermald.enable = true;

  # Set hyprlock as the resume command after sleep/suspend
  powerManagement.resumeCommands = "${pkgs.hyprlock}/bin/hyprlock";

  # Configure TLP for power management
  services.tlp = {
    enable = true;
    settings = {
      # Set CPU governor based on power source
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";

      # Set CPU energy performance policy
      CPU_ENERGY_PERF_POLICY_ON_BAT = "power";
      CPU_ENERGY_PERF_POLICY_ON_AC = "performance";

      # Set CPU performance limits
      CPU_MIN_PERF_ON_AC = 0;
      CPU_MAX_PERF_ON_AC = 100;
      CPU_MIN_PERF_ON_BAT = 0;
      CPU_MAX_PERF_ON_BAT = 60;
    };
  };

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
}
