{
  imports = [
    ./desktop
    ./programs
    ./themeing.nix
    ./accounts.nix
    ./options.nix
    ./syncthing.nix
    ./scripts
    ../../modules
  ];

  home = {
    username = "wolf";
    stateVersion = "23.11";
  };
}
