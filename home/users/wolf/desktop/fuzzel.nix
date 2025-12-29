{config, ...}: (
  with config.colorScheme.palette; {
    programs.fuzzel = {
      enable = true;
      settings = {
        colors = {
          background = "${base00}ff";
          text = "${base05}ff";
          match = "${base0A}ff";
          selection = "${base03}ff";
          selection-text = "${base05}ff";
          selection-match = "${base0A}ff";
          border = "${base0D}ff";
        };

        main = {
          font = "${config.theme.font.name}:size=12";
          dpi-aware = "no";
          width = 110;
          horizontal-pad = 17;
          line-height = 20;
          fields = "name,generic,comment,categories,filename,keywords,exec";
          show-actions = true;
          launch-prefix = "app2unit --fuzzel-compat --";
        };

        border = {
          width = 2;
          radius = config.theme.rounding;
        };
      };
    };
  }
)
