{
  pkgs,
  osConfig,
  ...
}: {
  programs.zed-editor = {
    enable = true;
    package = pkgs.symlinkJoin {
      name = "zed";
      paths = [pkgs.zed-editor];
      buildInputs = [pkgs.makeWrapper];
      postBuild = ''
        wrapProgram "$out/bin/zeditor" \
        --prefix PATH : "${
          pkgs.lib.makeBinPath (
            with pkgs; [
              eslint
              docker-compose-language-service
              copilot-language-server
              nil
              vscode-js-debug
              gopls
              llvmPackages_20.clang-unwrapped
              rust-analyzer
              basedpyright
              superhtml
              tinymist
              nil
              nixd
              biome
              vtsls
              tailwindcss-language-server
              tailwindcss
              deno
              nodePackages.bash-language-server
              jdt-language-server
              texlab
              tinymist
              nil
              nodePackages.vscode-langservers-extracted
              taplo
              docker-compose-language-service
              dockerfile-language-server-nodejs
              phpactor
              lemminx
              just-lsp
              nushell
              perl538Packages.PLS
              jq-lsp
              perlnavigator
            ]
          )
        }" \
          --run 'export ANTHROPIC_API_KEY="$(cat ${osConfig.sops.secrets."api-keys/anthropic".path})"' \
          --run 'export XAI_API_KEY="$(cat ${osConfig.sops.secrets."api-keys/xai".path})"' \
          --run 'export OPENAI_API_KEY="$(cat ${osConfig.sops.secrets."api-keys/openai".path})"' \
          --run 'export GEMINI_API_KEY="$(cat ${osConfig.sops.secrets."api-keys/google".path})"' \
          --add-flags "--new" \
          --add-flags "--wait"
      '';
    };

    userSettings = builtins.fromJSON (builtins.readFile ./settings.json);
    userKeymaps = builtins.fromJSON (builtins.readFile ./keymap.json);

    themes = builtins.mapAttrs (name: value: ./themes + ("/" + name)) (builtins.readDir ./themes);
  };

  programs.zed-editor-extensions = {
    enable = true;
    packages = with pkgs.zed-extensions; [
      html
      toml
      basher
      java
      sql
      latex
      typst
      nix
      mdx
      docker-compose
      dockerfile
      php
      xml
      biome
      proto
      just
      scheme
      nu
      perl
      jq
      make
      codebook
      deno
      git-firefly
      astro
      comment
      caddyfile
      nginx
    ];
  };
}
