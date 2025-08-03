{
  imports = [
    ./desktop
    ./programs
    ./themeing.nix
    ./accounts.nix
    ./options.nix
    ./scripts
    ../../modules
  ];

  home = {
    username = "wolf";
    stateVersion = "23.11";
  };
}
