{pkgs, ...} @ args: {
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    syntaxHighlighting.enable = true;
    autosuggestion.enable = true;
    shellAliases = import ./aliases.nix args;
    oh-my-zsh = {
      enable = true;
      plugins = ["colorize"];
      "theme" = "fino";
    };
    initContent =
      # bash
      ''
        unpersist() {
          local target="$1"
          local tempfile=$(mktemp)
          cp -L "$target" "$tempfile" || return
          rm -rf "$target"
          cp -a "$tempfile" "$target"
          chmod --reference="$tempfile" "$target"
          rm -rf "$tempfile"
        }
      '';
    plugins = [
      {
        name = "zsh-nix-shell";
        file = "nix-shell.plugin.zsh";
        src = pkgs.fetchFromGitHub {
          owner = "chisui";
          repo = "zsh-nix-shell";
          rev = "v0.8.0";
          sha256 = "1lzrn0n4fxfcgg65v0qhnj7wnybybqzs4adz7xsrkgmcsr0ii8b7";
        };
      }
      {
        name = "vi-mode";
        src = pkgs.zsh-vi-mode;
        file = "share/zsh-vi-mode/zsh-vi-mode.plugin.zsh";
      }
    ];
    sessionVariables = {
      TERM = "xterm-256color";
    };
  };
}
