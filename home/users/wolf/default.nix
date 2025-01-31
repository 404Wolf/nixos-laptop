{
  pkgs,
  config,
  osConfig,
  ...
}: {
  imports = [
    ./desktop
    ./programs
    ./themeing.nix
    ./accounts.nix
    ./system
    ../../modules
  ];

  home = rec {
    stateVersion = "23.11";
    username = "wolf";
    file = import ./system/files.nix {
      inherit pkgs osConfig config;
      homeDirectory = "/home/${username}";
    };
    sessionVariables = {
      NIX_PATH = "$HOME/.nix-defexpr/channels:$NIX_PATH";
    };
  };
}
