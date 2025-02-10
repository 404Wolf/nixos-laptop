{pkgs, ...}: {
  services.hypridle = {
    enable = true;

    settings = {
      general = {
        lock_cmd = "pidof hyprlock || ${pkgs.hyprlock}/bin/hyprlock"; # avoid starting multiple hyprlock instances
        before_sleep_cmd = "loginctl lock-session"; # lock before suspend
        after_sleep_cmd = "hyprctl dispatch dpms on"; # avoid having to press key twice to turn on display
      };

      listener = let
        bctl = "${pkgs.brightnessctl}/bin/brightnessctl";
        keylight = "framework_laptop::kbd_backlight";
      in [
        {
          timeout = 300; # 5min
          on-timeout = "${bctl} --save && ${bctl} s 10%"; # set monitor backlight to 10%
          on-resume = "${bctl} -r"; # restore monitor backlight
        }
        {
          timeout = 300; # 5min
          on-timeout = "${bctl} --save -d ${keylight} && ${bctl} -d ${keylight} s 0%"; # turn off keyboard backlight
          on-resume = "${bctl} -d ${keylight} -r"; # restore keyboard backlight
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
