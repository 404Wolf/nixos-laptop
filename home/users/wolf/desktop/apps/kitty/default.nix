{
  config,
  helpers,
  ...
}: {
  programs.kitty = {
    enable = true;
    shellIntegration.enableZshIntegration = true;
    settings = {
      enable_audio_bell = false;
      font_family = "FiraCode";
      font_size = 12;
      enable_ligatures = "always";

      foreground = "#${config.colorScheme.palette.base05}";
      background = "#${config.colorScheme.palette.base00}";

      cursor_blink_interval = 0.5; # Half-second blink rate
      cursor_stop_blinking_after = 15.0; # Stop blinking after 15 seconds of inactivity
      cursor_trail = 0; # Disable cursor trail effect

      scrollback_lines = 10000; # Increased from 2000 for more history
      scrollback_indicator_opacity = 1.0; # Fully visible scrollback indicator
      scrollback_fill_enlarged_window = "no";
      wheel_scroll_multiplier = 5.0;
      wheel_scroll_min_lines = 1;
      touch_scroll_multiplier = 1.0;

      mouse_hide_wait = 3.0; # Hide mouse after 3 seconds of inactivity
    };

    # Disabling default keyboard shortcuts
    extraConfig =
      ''
        map ctrl+shift+enter no_op
        map ctrl+shift+w no_op
        map ctrl+shift+] no_op
        map ctrl+shift+[ no_op
        map ctrl+shift+f no_op
        map ctrl+shift+b no_op
        map ctrl+shift+` no_op
        map ctrl+shift+1 no_op
        map ctrl+shift+2 no_op
        map ctrl+shift+3 no_op
        map ctrl+shift+4 no_op
        map ctrl+shift+5 no_op
        map ctrl+shift+6 no_op
        map ctrl+shift+7 no_op
        map ctrl+shift+8 no_op
        map ctrl+shift+9 no_op
        map ctrl+shift+0 no_op
        map ctrl+shift+l no_op
        map ctrl+shift+h no_op
        map ctrl+shift+k no_op
        map ctrl+shift+j no_op
        map ctrl+shift+q no_op
        map ctrl+shift+t no_op
        map ctrl+shift+alt+t no_op
      ''
      + (helpers.template ./template.mustache {
        inherit
          (config.colorScheme.palette)
          base00
          base01
          base02
          base03
          base04
          base05
          base06
          base07
          base08
          base09
          base0A
          base0B
          base0C
          base0D
          base0E
          base0F
          ;
      });
  };
}
