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
    ./rclone.nix
    ./codex.nix
  ];

  programs = {
    home-manager.enable = true;
  };

  home.sessionVariables = {
    PATH = "${config.lib.makeBinPath [
      "${config.home.homeDirectory}/.deno"
      "${config.home.homeDirectory}/.cargo"
    ]}:$PATH";
  };
}
