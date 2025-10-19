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
          }
        ];
      };
      theme.mgr = {
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
    };
  }
