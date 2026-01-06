{
  pkgs,
  config,
  osConfig,
  ...
}: {
  home.packages = with pkgs; [restic resticprofile];

  home.file."${config.xdg.configHome}/resticprofile/profiles.yaml".text =
    builtins.toJSON (import ./profiles.nix {inherit osConfig config;});
}
