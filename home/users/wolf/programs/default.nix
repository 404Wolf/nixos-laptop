{config, ...}: {
  imports = [
    ./git
    ./tmux
    ./yazi
    ./zsh
    ./extras.nix
    ./gpt
    ./rbw.nix
    ./go.nix
    ./restic
    ./direnv.nix
    ./ssh.nix
    ./zoxide.nix
  ];

  programs = {
    home-manager.enable = true;
  };

  home.sessionVariables = {
    PATH = "${config.home.homeDirectory}/.deno/bin:$PATH";
  };
}
