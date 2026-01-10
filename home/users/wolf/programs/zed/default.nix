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
              yaml-language-server
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
              dockerfile-language-server
              phpactor
              lemminx
              just-lsp
              nushell
              # perl538Packages.PLS
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
          --run 'if [ ! -t 1 ]; then EXTRA_FLAGS="--wait"; fi' \
          --add-flags '$EXTRA_FLAGS'
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
      jq
      make
      perl
      codebook
      deno
      git-firefly
      astro
      comment
      caddyfile
      nginx
      zig
    ];
  };
}
