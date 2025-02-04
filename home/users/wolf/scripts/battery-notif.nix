{pkgs, ...}: {
  systemd.user.services.battery-monitor = {
    Unit = {
      Description = "Low battery monitor";
      After = ["graphical-session.target"];
    };
    Service = {
      ExecStart = "${pkgs.writeShellApplication {
        name = "lowbattery-alert";
        runtimeInputs = with pkgs; [acpi libnotify];
        text = ''
          while true; do
            battery_level=$(acpi -b | grep -P -o '[0-9]+(?=%)')
            if [ "$battery_level" -le 6 ]; then
              notify-send "Battery Low" "Battery level is $battery_level!"
            fi
            sleep 60
          done
        '';
      }}/bin/lowbattery-alert";
      Restart = "always";
      RestartSec = "30s";
    };
    Install = {
      WantedBy = ["graphical-session.target"];
    };
  };
}
