{
  imports = [
    ./git
    ./tmux
    ./yazi
    ./zsh
    ./extras.nix
    ./gpt.nix
    ./rbw.nix
    ./go.nix
    ./direnv.nix
    ./zoxide.nix
  ];

  programs = {
    home-manager.enable = true;
  };
}
