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
    ./steam
  ];

  programs = {
    home-manager.enable = true;
  };
}
