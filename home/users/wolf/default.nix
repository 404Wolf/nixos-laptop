{config, ...}: {
  imports = [
    ./desktop
    ./programs
    ./themeing.nix
    ./accounts.nix
    ./scripts
    ../../modules
  ];

  home = {
    stateVersion = "23.11";
    username = "wolf";
    sessionVariables = {
      NIX_PATH = "$HOME/.nix-defexpr/channels:$NIX_PATH";
    };
  };
}
