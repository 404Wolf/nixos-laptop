{
  pkgs,
  config,
  lib,
  ...
}: {
  systemd.user =
    lib.recursiveUpdate
    {
      services.wallpaper-refresh = {
        Unit = {
          Description = "Refresh wallpaper";
          After = ["graphical-session.target"];
        };
        Service = {
          Type = "oneshot";
          ExecStart = pkgs.writeShellScript "wallpaper-refresh" ''
            options="${./photos}"
            random_png=$(find "$options" -type f -name "*.png" | shuf -n 1)
            cp -f "$random_png" ${config.my.variables.wallpaper-path}
            hyprctl hyprpaper reload ,"${config.my.variables.wallpaper-path}"
          '';
        };
      };

      timers.wallpaper-refresh = {
        Unit = {
          Description = "Timer for refreshing wallpaper";
          After = ["graphical-session.target"];
        };
        Timer = {
          OnBootSec = "1min";
          OnUnitActiveSec = "3h";
        };
        Install.WantedBy = ["timers.target"];
      };

      services.blueman-applet = {
        Unit = {
          Description = "Blueman bluetooth applet";
          After = ["graphical-session.target"];
        };
        Service = {
          Type = "exec";
          ExecStart = "${pkgs.blueman}/bin/blueman-applet";
          Restart = "always";
        };
        Install = {
          WantedBy = ["graphical-session.target"];
        };
      };

      services.nm-applet = {
        Unit = {
          Description = "NetworkManager system tray applet";
          After = ["graphical-session.target"];
        };
        Service = {
          Type = "exec";
          ExecStart = "${pkgs.networkmanagerapplet}/bin/nm-applet";
          Restart = "always";
        };
        Install = {
          WantedBy = ["graphical-session.target"];
        };
      };

      services.cliphist-text = {
        Unit = {
          Description = "Cliphist text clipboard history";
          After = ["graphical-session.target"];
        };
        Service = {
          Type = "exec";
          ExecStart = "${pkgs.wl-clipboard}/bin/wl-paste --type text --watch ${pkgs.cliphist}/bin/cliphist store";
          Restart = "always";
        };
        Install = {
          WantedBy = ["graphical-session.target"];
        };
      };

      services.cliphist-image = {
        Unit = {
          Description = "Cliphist image clipboard history";
          After = ["graphical-session.target"];
        };
        Service = {
          Type = "exec";
          ExecStart = "${pkgs.wl-clipboard}/bin/wl-paste --type image --watch ${pkgs.cliphist}/bin/cliphist store";
          Restart = "always";
        };
        Install = {
          WantedBy = ["graphical-session.target"];
        };
      };

      services.hyprpolkitagent = {
        Unit = {
          Description = "Hyprland polkit authentication agent";
          After = ["graphical-session.target"];
        };
        Service = {
          Type = "exec";
          ExecStart = "${pkgs.hyprpolkitagent}/libexec/hyprpolkitagent";
          Restart = "on-failure";
        };
        Install = {
          WantedBy = ["graphical-session.target"];
        };
      };

      services.udiskie = {
        Unit = {
          Description = "Automatically mount/unmount removable media";
          After = ["graphical-session.target"];
        };
        Service = {
          Type = "exec";
          ExecStart = "${pkgs.udiskie}/bin/udiskie --tray --notify --automount";
          Restart = "on-failure";
        };
        Install = {
          WantedBy = ["graphical-session.target"];
        };
      };
    }
    {
      services = builtins.listToAttrs (
        map
        (app: {
          name = app.name;
          value = {
            Unit = {
              Description = app.description;
              After = ["graphical-session.target"];
            };
            Service = {
              Type = "exec";
              ExecStart = "${pkgs.writeShellScriptBin "start-${app.name}" ''
                if ${pkgs.procps}/bin/pgrep -x ${app.name} > /dev/null; then
                  exit 1
                fi

                exec ${app.package}/bin/${app.name}
              ''}/bin/start-${app.name}";
            };
            Install = {
              WantedBy = ["graphical-session.target"];
            };
          };
        })
        [
          {
            name = "obsidian";
            description = "Obsidian note-taking application";
            package = pkgs.obsidian;
          }
          {
            name = "beeper";
            description = "Beeper messaging application";
            package = pkgs.beeper;
          }
          {
            name = "thunderbird";
            description = "Thunderbird email client";
            package = pkgs.thunderbird;
          }
        ]
      );
    };
}
