{pkgs, ...}: {
  services.hypridle = {
    enable = true;

    settings = {
      general = {
        lock_cmd = "pidof hyprlock || ${pkgs.hyprlock}/bin/hyprlock"; # avoid starting multiple hyprlock instances
        before_sleep_cmd = "loginctl lock-session"; # lock before suspend
        after_sleep_cmd = "hyprctl dispatch dpms on"; # avoid having to press key twice to turn on display
        cleanup_cmd = "rm -f /tmp/brightness_* || true"; # cleanup tempfiles on service stop
      };

      listener = let
        bctl = "${pkgs.brightnessctl}/bin/brightnessctl";
        keylight = "framework_laptop::kbd_backlight";
        backlight = "amdgpu_bl1";

        # Save current brightness to tempfile
        saveBrightness = device: ''
          ${bctl} -d ${device} g > /tmp/brightness_${device}
        '';

        # Restore brightness from tempfile
        restoreBrightness = device: ''
          if [ -f /tmp/brightness_${device} ]; then
            ${bctl} -d ${device} s $(cat /tmp/brightness_${device})
            rm -f /tmp/brightness_${device}
          fi
        '';
      in [
        {
          timeout = 300; # 5min
          on-timeout = "${saveBrightness backlight} && ${bctl} s 10%";
          on-resume = restoreBrightness backlight;
        }
        {
          timeout = 300; # 5min
          on-timeout = "${saveBrightness keylight} && ${bctl} -d ${keylight} s 0%";
          on-resume = restoreBrightness keylight;
        }
        {
          # suspend if on battery, otherwise lock
          timeout = 450; # 7.5min
          on-timeout = "if [ ! $(cat /sys/class/power_supply/ACAD/online) ]; then systemctl suspend; else loginctl lock-session; fi";
        }
        {
          timeout = 480; # 8min
          on-timeout = "hyprctl dispatch dpms off"; # turn off display
          on-resume = "hyprctl dispatch dpms on"; # turn on display when activity detected
        }
      ];
    };
  };
}
