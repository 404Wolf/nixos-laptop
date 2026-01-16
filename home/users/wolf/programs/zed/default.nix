{
  pkgs,
  osConfig,
  ...
}: let
  mdxGrammar = pkgs.buildZedGrammar {
    name = "mdx";
    version = "0f2d4b204b231e5ebb7b94ff0259bee6c83ebc58";

    src = pkgs.fetchFromGitHub {
      owner = "srazzak";
      repo = "tree-sitter-mdx";
      rev = "0f2d4b204b231e5ebb7b94ff0259bee6c83ebc58";
      hash = "sha256-KgWX69beW6obIwQ+jBHqr75cTSlH4PQwhXWHCIfZLEI=";
    };
  };

  mdxExt = pkgs.buildZedRustExtension {
    name = "mdx";
    version = "fix-codeblocks";

    src = pkgs.fetchFromGitHub {
      owner = "404wolf";
      repo = "zed-mdx";
      rev = "fix-codeblocks";
      hash = "sha256-eoST3IVJOj2Moc/R0uBQLbgqTtFPyOnMFIba8VxdrdM=";
    };

    cargoHash = "sha256-hea2GLQ04nBfmUEg1accjsWmZmMYllV3h8Kz3qlhZVY=";

    grammars = [mdxGrammar];
  };

  zeditorWrapper = pkgs.writeShellScriptBin "zeditor" ''
    export PATH="$PATH:${
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
          jq-lsp
          perlnavigator
        ]
      )
    }"

    export ANTHROPIC_API_KEY="$(cat ${osConfig.sops.secrets."api-keys/anthropic".path})"
    export XAI_API_KEY="$(cat ${osConfig.sops.secrets."api-keys/xai".path})"
    export OPENAI_API_KEY="$(cat ${osConfig.sops.secrets."api-keys/openai".path})"
    export GEMINI_API_KEY="$(cat ${osConfig.sops.secrets."api-keys/google".path})"

    if [ -t 1 ]; then
      exec ${pkgs.zed-editor}/bin/zed --new "$@"
    else
      exec ${pkgs.zed-editor}/bin/zed --new --wait "$@"
    fi
  '';
in {
  programs.zed-editor = {
    enable = true;

    package = zeditorWrapper;

    userSettings = builtins.fromJSON (builtins.readFile ./settings.json);
    userKeymaps = builtins.fromJSON (builtins.readFile ./keymap.json);

    themes = builtins.mapAttrs (name: value: ./themes + ("/" + name)) (builtins.readDir ./themes);
  };

  programs.zed-editor-extensions = {
    enable = true;
    packages = with pkgs.zed-extensions; [
      mdxExt
      html
      toml
      basher
      java
      sql
      latex
      typst
      nix
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
