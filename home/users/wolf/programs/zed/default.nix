{
  pkgs,
  osConfig,
  ...
}: let
  tokenFiles = {
    anthropic = osConfig.sops.secrets."api-keys/anthropic".path;
    openai = osConfig.sops.secrets."api-keys/openai".path;
    google = osConfig.sops.secrets."api-keys/google".path;
  };

  wrappedZed = pkgs.symlinkJoin {
    name = "zed";
    paths = [pkgs.zed-editor-fhs];
    buildInputs = [pkgs.makeWrapper];
    postBuild = ''
      wrapProgram "$out/bin/zed" \
        --run 'export GOOGLE_API_KEY="$(cat ${tokenFiles.google})"' \
        --run 'export ANTHROPIC_API_KEY="$(cat ${tokenFiles.anthropic})"' \
        --run 'export OPENAI_API_KEY="$(cat ${tokenFiles.openai})"'
    '';
  };
in {
  programs.zed-editor = {
    enable = true;
    package = wrappedZed;
    extensions = ["awk" "deno" "nix" "pylsp" "make" "react-typescript-snippets"];

    userSettings = builtins.fromJSON (builtins.readFile ./settings.json);
    userKeymaps = builtins.fromJSON (builtins.readFile ./keymap.json);

    themes = builtins.mapAttrs (name: value: builtins.readFile value) (builtins.readDir ./themes);
  };
}
