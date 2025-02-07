{pkgs, ...}: {
  services.hypridle = {
    enable = true;

    settings = {
      general = {
        lock_cmd = "pidof hyprlock || ${pkgs.hyprlock}/bin/hyprlock"; # avoid starting multiple hyprlock instances
        before_sleep_cmd = "loginctl lock-session"; # lock before suspend
        after_sleep_cmd = "hyprctl dispatch dpms on"; # avoid having to press key twice to turn on display
      };

      listener = [
        {
          timeout = 150; # 2.5min
          on-timeout = "${pkgs.brightnessctl}/bin/brightnessctl s 10%"; # set monitor backlight to 10%
          on-resume = "${pkgs.brightnessctl}/bin/brightnessctl -r"; # restore monitor backlight
        }
        {
          timeout = 150; # 2.5min
          on-timeout = "${pkgs.brightnessctl}/bin/brightnessctl -d framework_laptop::kbd_backlight s 0%"; # turn off keyboard backlight
          on-resume = "${pkgs.brightnessctl}/bin/brightnessctl -d framework_laptop::kbd_backlight -r"; # restore keyboard backlight
        }
        {
          # suspend if on battery, otherwise lock
          timeout = 300; # 5min
          on-timeout = "if [ $(cat /sys/class/power_supply/BAT*/status) = 'Discharging' ]; then systemctl suspend; else loginctl lock-session; fi";
        }
        {
          timeout = 330; # 5.5min
          on-timeout = "hyprctl dispatch dpms off"; # turn off display
          on-resume = "hyprctl dispatch dpms on"; # turn on display when activity detected
        }
        {
          timeout = 1800; # 30min
          on-timeout = "systemctl suspend"; # suspend system
        }
      ];
    };
  };
}
