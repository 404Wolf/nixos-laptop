{
  pkgs,
  config,
  ...
}: {
  systemd.user = {
    services.wallpaper-refresh = {
      Unit.Description = "Refresh wallpaper";
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
      Unit.Description = "Timer for refreshing wallpaper";
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
        Restart = "on-failure";
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
        Restart = "on-failure";
      };
      Install = {
        WantedBy = ["graphical-session.target"];
      };
    };

    services.obsidian = {
      Unit = {
        Description = "Obsidian note-taking application";
        After = ["graphical-session.target"];
      };
      Service = {
        Type = "exec";
        ExecStart = "${pkgs.obsidian}/bin/obsidian";
        Restart = "on-failure";
      };
      Install = {
        WantedBy = ["graphical-session.target"];
      };
    };

    services.beeper = {
      Unit = {
        Description = "Beeper messaging application";
        After = ["graphical-session.target"];
      };
      Service = {
        Type = "exec";
        ExecStart = "${pkgs.beeper}/bin/beeper";
        Restart = "on-failure";
      };
      Install = {
        WantedBy = ["graphical-session.target"];
      };
    };

    services.thunderbird = {
      Unit = {
        Description = "Thunderbird email client";
        After = ["graphical-session.target"];
      };
      Service = {
        Type = "exec";
        ExecStart = "${pkgs.thunderbird}/bin/thunderbird";
        Restart = "on-failure";
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
        Restart = "on-failure";
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
        Restart = "on-failure";
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
  };
}
