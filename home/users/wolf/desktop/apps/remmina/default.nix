{config, ...}: {
  imports = [./connect.nix];

  "${config.xdg.configHome}/remmina" = {
    enable = true;
    source = ./config-files;
  };
}
