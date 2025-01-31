{
  pkgs,
  config,
  helpers,
  ...
}: let
  mkBoth = fg: bg: {
    fg = "#${fg}";
    bg = "#${bg}";
  };
  mkSame = bg: mkBoth bg bg;
  mkFg = fg: {fg = "#${fg}";};
in
  with config.colorScheme.palette; {
    programs.yazi = {
      enable = true;
      enableZshIntegration = true;
      settings = {
        open.editor = [
          {
            open = [
              {
                run = ''${pkgs.xdg-utils}/bin/xdg-open "$@"'';
                desc = "Open";
              }
            ];
            play = [
              {
                run = ''${pkgs.vlc}/bin/vlc "$@"'';
                orphan = true;
                for = "unix";
              }
            ];
          }
        ];
      };
      theme.manager = {
        # Reusing bat themes, since it's suggested in the stying guide
        # https://yazi-rs.github.io/docs/configuration/theme#manager
        syntect_theme = helpers.template ./template.mustache config.colorScheme.palette;
        cwd = mkFg base0C;
        find_keyword = (mkFg base0B) // {bold = true;};
        find_position = mkFg base05;
        marker_selected = mkSame base0B;
        marker_copied = mkSame base0A;
        marker_cut = mkSame base08;
        tab_active = mkBoth base00 base0D;
        tab_inactive = mkBoth base05 base01;
        border_style = mkFg base04;
      };
      keymap = {
        input.prepend_keymap = [
          {
            run = "close";
            on = ["<C-q>"];
          }
          {
            run = "escape";
            on = ["<Esc>"];
          }
        ];
        manager.prepend_keymap = [
          {
            run = "escape";
            on = ["<Esc>"];
          }
          {
            run = "quit";
            on = ["q"];
          }
          {
            run = "quit --no-cwd-file";
            on = ["<C-q>"];
          }
          {
            run = [
              "cd"
              "quit"
            ];
            on = ["<C-Enter>"];
          }
        ];
      };
    };
  }
