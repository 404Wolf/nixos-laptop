{
  config,
  pkgs,
  nix-colors,
  ...
}: let
  gtkThemeFromScheme = (nix-colors.lib-contrib {inherit pkgs;}).gtkThemeFromScheme;
in {
  qt.platformTheme = "gtk2";

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
  };

  home.pointerCursor = {
    gtk.enable = true;
    package = pkgs.graphite-cursors;
    name = "graphite-dark";
    size = 17;
  };
}
