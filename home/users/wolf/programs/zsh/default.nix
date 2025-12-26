{pkgs, ...} @ args: let
  appletsDir = builtins.readDir ./applets;

  # Separate .func.sh files from regular applets
  funcFiles = builtins.filter (name: pkgs.lib.hasSuffix ".func.sh" name) (
    builtins.attrNames appletsDir
  );
  regularApplets = builtins.filter (name: !pkgs.lib.hasSuffix ".func.sh" name) (
    builtins.attrNames appletsDir
  );

  # Concatenate all .func.sh files
  funcContent = builtins.concatStringsSep "\n" (
    builtins.map (
      name: let
        src = builtins.readFile ./applets/${name};
        funcName = builtins.replaceStrings [".func.sh"] [""] name;
      in "function ${funcName}() {\n${src}\n}"
    )
    funcFiles
  );

  # Build regular applets (non-.func.sh files)
  applets = let
    applets =
      builtins.map (
        name:
          pkgs.writeShellApplication {
            name = builtins.replaceStrings [".sh"] [""] name;
            text = builtins.readFile ./applets/${name};
            runtimeInputs = with pkgs; [jq];
          }
      )
      regularApplets;
  in
    pkgs.buildEnv {
      name = "applets";
      paths = applets;
    };
in {
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
    initContent = ''
      PATH=$PATH:${applets}/bin

      ${funcContent}
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
