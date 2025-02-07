{
  config,
  pkgs,
  ...
}: let
  wallpaper = "${config.xdg.dataHome}/wallpapers";
in {
  programs.hyprlock = {
    enable = true;
    settings = {
      auth = {
        "fingerprint:enabled" = true;
      };
      general = {
        grace = 0;
        hide_cursor = true;
        no_fade_in = false;
      };
      background = [
        {
          path = "${wallpaper}/wallpaper.jpg";
          blur_passes = 0;
          blur_size = 3;
        }
      ];
      input-field = [
        {
          monitor = "";
          size = "250, 50";
          outline_thickness = 3;
          dots_size = 0.2; # Scale of input-field height, 0.2 - 0.8
          dots_spacing = 0.64; # Scale of dots' absolute size, 0.0 - 1.0
          dots_center = true;
          outer_color = "rgb(${config.colorscheme.palette.base02})";
          inner_color = "rgb(${config.colorScheme.palette.base00})";
          font_color = "rgb(${config.colorScheme.palette.base01})";
          fade_on_empty = true;
          placeholder_text = "Password"; # Text rendered in the input box when it's empty.
          position = "0, 80";
          halign = "center";
          valign = "bottom";
        }
      ];
      label = [
        {
          "monitor" = "";
          "text" = ''cmd[update:1000] echo "$(date +"%-I:%M%p")"'';
          "color" = "$foreground";
          "#color" = "rgba(255, 255, 255, 0.6)";
          "font_size" = 110;
          "font_family" = "monospace";
          "position" = "0, -300";
          "halign" = "center";
          "valign" = "top";
        }
        {
          "monitor" = "";
          "text" = "Salutations, $USER!";
          "color" = "$foreground";
          "font_size" = 23;
          "font_family" = "monospace";
          "position" = "0, -40";
          "halign" = "center";
          "valign" = "center";
        }
      ];
    };
  };

  systemd.user.services.hyprlock-on-sleep = {
    Unit = {
      Description = "Lock screen on suspend";
      Before = ["sleep.target" "suspend.target"];
    };
    Install = {
      WantedBy = ["sleep.target" "suspend.target"];
    };
    Service = {
      Type = "oneshot";
      Environment = "WAYLAND_DISPLAY=wayland-1 DISPLAY=:1";
      ExecStart = "${pkgs.hyprlock}/bin/hyprlock";
    };
  };
}
