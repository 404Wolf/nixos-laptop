{
  pkgs,
  config,
  ...
}: {
  "${config.xdg.configHome}/gpt-cli/gpt.yml" = {
    enable = true;
    text = import ../utils/gpt.nix {inherit pkgs;};
  };
}
