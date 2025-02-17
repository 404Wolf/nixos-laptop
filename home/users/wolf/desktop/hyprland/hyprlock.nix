{config, ...}: {
  programs.hyprlock = {
    enable = true;
    settings = {
      auth = {
        "fingerprint:enabled" = true;
      };
      animation = [
        "global:fadeOut, 0.2,1 0.5, linear"
      ];
      general = {
        grace = 5;
        hide_cursor = true;
        no_fade_in = false;
      };
      background = [
        {
          path = config.my.variables.wallpaper-path;
          blur_passes = 0;
          blur_size = 3;
        }
      ];
      input-field = [
        {
          monitor = "";
          size = "250, 50";
          outline_thickness = 3;
          dots_size = 0.2;
          dots_spacing = 0.64;
          dots_center = true;
          outer_color = "rgb(${config.colorscheme.palette.base02})";
          inner_color = "rgb(${config.colorScheme.palette.base00})";
          font_color = "rgb(${config.colorScheme.palette.base01})";
          fade_on_empty = true;
          placeholder_text = "Password";
          position = "0, 80";
          halign = "center";
          valign = "bottom";
        }
      ];
      label = [
        {
          "monitor" = "";
          "text" = ''cmd[update:1000] echo "$(date +"%H:%M")"'';
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
        {
          "monitor" = "";
          "text" = "$FPRINTPROMPT";
          "color" = "$foreground";
          "font_size" = 16;
          "font_family" = "monospace";
          "position" = "0, 20";
          "halign" = "center";
          "valign" = "bottom";
        }
      ];
    };
  };
}
