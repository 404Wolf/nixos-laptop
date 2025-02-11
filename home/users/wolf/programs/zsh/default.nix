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
    initExtra =
      # bash
      ''
        set -o vi

        function hyprland() {
          if ! sudo -v; then
           echo "Error: Failed to obtain sudo privileges"
           return 1
          fi

          # Start Hyprland with max priority
          Hyprland &

          # Wait for Hyprland to start
          sleep 2

          # Get Hyprland PID
          HYPRLAND_PID=$(pgrep Hyprland)

          # Set OOM score
          sudo echo -1000 > /proc/$HYPRLAND_PID/oom_score_adj

          # Set process priority
          sudo renice -n -15 -p $HYPRLAND_PID
        }
      '';
  };
}
