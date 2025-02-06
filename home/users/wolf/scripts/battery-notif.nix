{pkgs, ...}: {
  systemd.user.services.battery-monitor = {
    Unit = {
      Description = "Low battery monitor";
      After = ["graphical-session.target"];
    };
    Service = {
      ExecStart = "${pkgs.writeShellApplication {
        name = "lowbattery-alert";
        runtimeInputs = with pkgs; [acpi libnotify dunst];
        text = ''
          while true; do
            echo "Checking power status..."
            ac_powered=$(acpi -a | grep -c "on-line")
            echo "AC Power status: $ac_powered (1 = plugged in, 0 = on battery)"

            if [ "$ac_powered" -eq 0 ]; then
              echo "Running on battery power, checking battery level..."
              battery_level=$(acpi -b | grep -P -o '[0-9]+(?=%)')
              echo "Current battery level: $battery_level%"

              if [ "$battery_level" -le 7 ]; then
                echo "Battery level critical! Checking DND status..."
                dnd_state=$(dunstctl is-paused)

                if [ "$dnd_state" = "true" ]; then
                  echo "DND is on, temporarily disabling..."
                  dunstctl set-paused false
                  notify-send "Battery Low" "Battery level is $battery_level!"
                  sleep 5
                  echo "Re-enabling DND..."
                  dunstctl set-paused true
                else
                  echo "DND is off, sending notification normally..."
                  notify-send "Battery Low" "Battery level is $battery_level!"
                fi
              else
                echo "Battery level okay, no notification needed"
              fi
            else
              echo "AC power connected, no need to check battery"
            fi

            echo "Sleeping for 60 seconds..."
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
