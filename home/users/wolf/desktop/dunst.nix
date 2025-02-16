{
  config,
  pkgs,
  ...
}: (with config.colorScheme.palette; {
  home.packages = [pkgs.libnotify];

  services.dunst = {
    enable = true;
    iconTheme = {
      name = "Moka";
      package = pkgs.moka-icon-theme;
    };
    settings = {
      global = {
        monitor = "0";
        origin = "bottom-right";
        offset = "10x10";
        progress_bar = true;
        separator_color = "frame";
        sort = "yes";
        idle_threshold = 120;
        markup = "full";
        show_age_threshold = 60;
        ignore_newline = "no";
        stack_duplicates = true;
        sticky_history = "yes";
        history_length = 20;
        always_run_script = true;
        corner_radius = config.theme.rounding;
        follow = "mouse";
        font = config.theme.font.name;
        format = "<b>%s</b>\\n%b";
        frame_color = "#${base00}";
        highlight = "#${base04}";
        foreground = "#${base05}";
        frame_width = 1;
        icon_position = "left";
        indicate_hidden = "yes";
        min_icon_size = 0;
        max_icon_size = 40;
        mouse_left_click = "do_action, close_current";
        mouse_middle_click = "close_current";
        mouse_right_click = "close_all";
        show_indicators = "yes";
        shrink = "no";
        word_wrap = "yes";
      };

      urgency_low = {
        background = "#${base00}";
        foreground = "#${base05}";
        frame_color = "#${base0B}";
      };

      urgency_normal = {
        background = "#${base00}";
        foreground = "#${base05}";
        frame_color = "#${base0E}";
      };

      urgency_critical = {
        background = "#${base00}";
        foreground = "#${base05}";
        frame_color = "#${base08}";
      };

      fullscreen_delay_everything = {fullscreen = "delay";};
    };
  };
})
