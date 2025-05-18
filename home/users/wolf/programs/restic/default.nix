{
  pkgs,
  config,
  ...
}: {
  home.packages = with pkgs; [restic resticprofile];
  home.file."${config.xdg.configHome}/resticprofile/profiles.yaml".text = builtins.readFile ./profiles.yaml;
}
