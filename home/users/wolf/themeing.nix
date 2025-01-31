{
  pkgs,
  nix-colors,
  ...
}: {
  imports = [
    nix-colors.homeManagerModules.default
  ];

  theme = {
    font.package = pkgs.fira-code;
    rounding = 5;
  };
  colorScheme = {
    slug = "onedark-extra-dark";
    name = "OneDark Extra Dark";
    author = "Adapted from OneDark by Lalit Magant";
    palette = {
      base00 = "#000000";
      base01 = "#303030";
      base02 = "#353535";
      base03 = "#4A4A4A";
      base04 = "#B2CCD6";
      base05 = "#EEFFFF";
      base06 = "#EEFFFF";
      base07 = "#FFFFFF";
      base08 = "#F07178";
      base09 = "#F78C6C";
      base0A = "#FFCB6B";
      base0B = "#C3E88D";
      base0C = "#89DDFF";
      base0D = "#82AAFF";
      base0E = "#C792EA";
      base0F = "#FF5370";
    };
  };
}
