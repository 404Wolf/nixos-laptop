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

      listener = [
        {
          timeout = 300; # 5min
          on-timeout = ''
            if [ ! $(cat /sys/class/power_supply/ACAD/online) ]; then
              ${pkgs.brightnessctl}/bin/brightnessctl -d amdgpu_bl1 g > /tmp/brightness_amdgpu_bl1
              ${pkgs.brightnessctl}/bin/brightnessctl s 10%;
            fi
          '';
          on-resume = ''
            if [ -f /tmp/brightness_amdgpu_bl1 ]; then
              ${pkgs.brightnessctl}/bin/brightnessctl -d amdgpu_bl1 s $(cat /tmp/brightness_amdgpu_bl1)
              rm -f /tmp/brightness_amdgpu_bl1;
            fi
          '';
        }
        {
          timeout = 300; # 5min
          on-timeout = "if [ ! $(cat /sys/class/power_supply/ACAD/online) ]; then ${pkgs.brightnessctl}/bin/brightnessctl -d framework_laptop::kbd_backlight g > /tmp/brightness_framework_laptop::kbd_backlight &&             
 ${pkgs.brightnessctl}/bin/brightnessctl -d framework_laptop::kbd_backlight s 0%; fi";
          on-resume = "if [ -f /tmp/brightness_framework_laptop::kbd_backlight ]; then ${pkgs.brightnessctl}/bin/brightnessctl -d framework_laptop::kbd_backlight s $(cat /tmp/brightness_framework_laptop::kbd_backlight) && r 
 -f /tmp/brightness_framework_laptop::kbd_backlight; fi";
        }
        {
          # suspend if on battery
          timeout = 450; # 7.5min
          on-timeout = "if [ ! $(cat /sys/class/power_supply/ACAD/online) ]; then systemctl suspend; fi";
        }
        {
          # lock on AC after 10 minutes
          timeout = 600; # 10min
          on-timeout = "if [ $(cat /sys/class/power_supply/ACAD/online) ]; then loginctl lock-session; fi";
        }
        {
          timeout = 600; # 10min
          on-timeout = "hyprctl dispatch dpms off"; # turn off display
          on-resume = "hyprctl dispatch dpms on"; # turn on display when activity detected
        }
      ];
    };
  };
}
