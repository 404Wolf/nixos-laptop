{
  config,
  pkgs,
  nix-colors,
  ...
}: let
  gtkThemeFromScheme = (nix-colors.lib-contrib {inherit pkgs;}).gtkThemeFromScheme;
in {
  qt.platformTheme = "gtk2";

  home.sessionVariables = {
    XCURSOR_PATH = "${pkgs.graphite-cursors}/share/icons";
    XCURSOR_SIZE = 14;
    XCURSOR_THEME = "graphite-dark";
  };

  gtk = {
    enable = true;

    theme = {
      name = "${config.colorScheme.slug}";
      package = gtkThemeFromScheme {scheme = config.colorScheme;};
    };

    iconTheme = {
      package = pkgs.zafiro-icons;
      name = "Zafiro-icons-Dark";
    };

    cursorTheme = {
      package = pkgs.graphite-cursors;
      name = "graphite-dark";
      size = 17;
    };
  };
}
