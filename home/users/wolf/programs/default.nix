{config, ...}: {
  imports = [
    ./git
    ./tmux
    ./yazi
    ./zsh
    ./extras.nix
    ./gpt
    ./go.nix
    ./rbw.nix
    ./restic
    ./direnv.nix
    ./ssh.nix
    ./zoxide.nix
    ./zed
    ./rclone.nix
  ];

  programs = {
    home-manager.enable = true;
  };

  home.sessionVariables = {
    PATH = "${config.home.homeDirectory}/.deno/bin:${config.home.homeDirectory}/.cargo/bin:$PATH";
  };
}
