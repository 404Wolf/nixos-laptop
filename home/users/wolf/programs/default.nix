{config, ...}: {
  imports = [
    ./git
    ./tmux
    ./yazi
    ./zsh
    ./extras.nix
    ./gpt
    ./rbw.nix
    ./restic
    ./direnv.nix
    ./ssh.nix
    ./zoxide.nix
    ./zed
  ];

  programs = {
    home-manager.enable = true;
  };

  home.sessionVariables = {
    PATH = "${config.home.homeDirectory}/.deno/bin:${config.home.homeDirectory}/.cargo/bin:$PATH";
  };
}
