{
  pkgs,
  osConfig,
  ...
}: {
  # Hyprland stuff
  coltman_monitors = "cp ~/.config/hypr/1947Coltman.conf ~/.config/hypr/monitors.conf";

  # Utilities
  gpt =
    "GOOGLE_API_KEY=$(cat ${osConfig.sops.secrets."api-keys/google".path}) "
    + "ANTHROPIC_API_KEY=$(cat ${osConfig.sops.secrets."api-keys/anthropic".path}) "
    + "OPENAI_API_KEY=$(cat ${osConfig.sops.secrets."api-keys/openai".path}) "
    + "${pkgs.gpt-cli}/bin/gpt";

  restic = "RESTIC_PASSWORD=${
    osConfig.sops.secrets."other/restic/password".path
  } ${pkgs.restic}/bin/restic";

  # File navigation
  ".." = "../..";
  "..." = "../../..";
  "...." = "../../../..";
  ls = "${pkgs.eza}/bin/eza";
  lsd = "${pkgs.lsd}/bin/lsd -al --git";
  cdtmp = "cd $(mktemp -d) && pwd | copy";
  cpc = ''cp $(wl-paste | sed "s|file://||")'';

  # Copy paste
  copy = "wl-copy";
  paste = "wl-paste";

  # File manipulation
  cat = "bat";

  # Nix stuff
  nix-allow-unfree = "export NIXPKGS_ALLOW_UNFREE=1";
  nix-disallow-unfree = "export NIXPKGS_ALLOW_UNFREE=1";
  nix-rebuild-laptop = "nix run .#rebuild nixos laptop";
  nix-rebuild-desktop = "nix run .#rebuild nixos desktop";
  universal-term = "export TERM=screen-256color";
  nb = "nix build";
  nd = "nix develop";
  nr = "nix run";

  # Direnv stuff
  dr = "direnv reload";
  da = "direnv allow";

  # Git Aliases
  g = "git";
  ga = "git add";
  gaa = "git add --all";
  gp = "git push";
  gpl = "git pull";
  gs = "git status";
  gd = "git diff HEAD | delta --side-by-side";
  gc = "git commit";
  gcb = "git checkout -b";
  gw = "git switch";
  lg = "lazygit";

  # Tmux Aliases
  tmns = "tmux new-session -s ";
  tmsw = "${
    pkgs.writeShellApplication {
      name = "choose_tmux_session";
      runtimeInputs = [
        pkgs.fzf
        pkgs.tmux
      ];
      text = ''
        session="$(tmux list-sessions -F "#S" | fzf)"
        if [ -n "$session" ]; then
          tmux attach-session -t "$session"
        fi
      '';
    }
  }/bin/choose_tmux_session";
  tma = "tmux attach-session -t ";
  tmls = "tmux list-sessions";
  tmks = "tmux kill-session -t ";
  nv = "nvim";
}
