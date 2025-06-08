{
  pkgs,
  pkgs-unstable,
  osConfig,
  ...
}: let
  fzf = "${pkgs.fzf}/bin/fzf";
  neovim = "${pkgs.wrappedNvim}/bin/nvim";
  neovide = "${pkgs.neovide}/bin/neovide";
  bat = "${pkgs.bat}/bin/bat";
  git = "${pkgs.git}/bin/git";
  delta = "${pkgs.delta}/bin/delta";
  tmux = "${pkgs.tmux}/bin/tmux";

  tokenFiles = {
    anthropic = osConfig.sops.secrets."api-keys/anthropic".path;
    openai = osConfig.sops.secrets."api-keys/openai".path;
    google = osConfig.sops.secrets."api-keys/google".path;
  };
in {
  # Wakeup hyprland
  hypr-wakeup = "hyprctl dispatch dpms on eDP-1 && hyprctl dispatch dpms on DP-6 && hyprctl dispatch dpms on DP-8";

  # Utilities
  gpt =
    "GOOGLE_API_KEY=$(cat ${tokenFiles.google}) "
    + "ANTHROPIC_API_KEY=$(cat ${tokenFiles.anthropic}) "
    + "OPENAI_API_KEY=$(cat ${tokenFiles.openai}) "
    + "${pkgs-unstable.gpt-cli}/bin/gpt";
  gpt-tmux = "${pkgs.writeShellScriptBin "gpt-tmux" (builtins.readFile ./scripts/gpt-tmux.sh)}/bin/gpt-tmux";
  dalle =
    "OPENAI_API_KEY=$(cat ${tokenFiles.openai}) "
    + "${pkgs.dalleCLI}/bin/dallecli";
  website-dump = "${pkgs.writeShellScriptBin "website-dump" (builtins.readFile ./scripts/website_dump.sh)}/bin/website_dump";
  restic = "RESTIC_PASSWORD=${osConfig.sops.secrets."other/restic/password".path} ${pkgs.restic}/bin/restic";

  # File navigation
  ".." = "../..";
  "..." = "../../..";
  "...." = "../../../..";
  ls = "${pkgs.eza}/bin/eza";
  lsd = "${pkgs.lsd}/bin/lsd -al --git";
  cdtmp = "cd $(mktemp -d) && pwd | copy";
  cpd = "cp $(\"${fzf}\") .";
  cpc = ''cp $(wl-paste | grep -o "/tmp.*")'';

  # Copy paste
  copy = "${pkgs.wl-clipboard}/bin/wl-copy";
  paste = "${pkgs.wl-clipboard}/bin/wl-paste";

  # File manipulation
  cat = "${pkgs.bat}/bin/bat";

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

  # FZF Aliases
  fzf = "${fzf} --preview '${bat} --color=always {}'";
  fzo = "TO_OPEN=\"$(${fzf})\" && open $TO_OPEN 2>& /dev/null & disown";
  fzv = "nvim \"$(${fzf})\"";
  fzfcd = "z $(find * -type d | \"${fzf}\")";
  fzfcp = "cat $(\"${fzf}\") | copy";
  # Chatgpt fancy bash command that lets you scroll through history
  fzfsh = "history | ${fzf} +s --tac | awk '{print substr($0,index($0,$3))}' | sh";

  # Git Aliases
  g = "${git}";
  ga = "${git} add";
  gaa = "${git} add --all";
  gp = "${git} push";
  gpl = "${git} pull";
  gs = "${git} status";
  gd = "${git} diff HEAD | ${delta} --side-by-side";
  gc = "${git} commit";
  gcb = "${git} checkout -b";
  gw = "${git} switch";
  lg = "${pkgs.lazygit}/bin/lazygit";
  grc = "gh repo list 404wolf | fzf --prompt=\"Select repo: \" --preview=\"gh repo view {1}\" | xargs -I {} gh repo clone {}";

  # Tmux Aliases
  tmns = "${tmux} new-session -s ";
  tmsw = "${pkgs.writeShellApplication {
    name = "choose_tmux_session";
    runtimeInputs = [pkgs.fzf pkgs.tmux];
    text = ''
      session="$(tmux list-sessions -F "#S" | fzf)"
      if [ -n "$session" ]; then
        tmux attach-session -t "$session"
      fi
    '';
  }}/bin/choose_tmux_session";
  tma = "${tmux} attach-session -t ";
  tmls = "${tmux} list-sessions";
  tmks = "${tmux} kill-session -t ";

  # Neovim aliases
  nv = neovim;
  nn = neovide;
}
