{
  imports = [
    ./git
    ./tmux
    ./neomutt
    ./yazi
    ./zsh
    ./zoxide
    ./direnv
    ./rbw
    ./extras.nix
  ];

  programs = {
    home-manager.enable = true;
  };
}
