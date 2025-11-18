{
  pkgs,
  osConfig,
  ...
}: let
  wrappedZed = pkgs.symlinkJoin {
    name = "zed";
    paths = [pkgs.zed-editor];
    buildInputs = [pkgs.makeWrapper];
    postBuild = ''
      wrapProgram "$out/bin/zeditor" \
      --prefix PATH : "${pkgs.lib.makeBinPath [pkgs.copilot-language-server]}" \
        --run 'export GOOGLE_API_KEY="$(cat ${osConfig.sops.secrets."api-keys/google".path})"' \
        --run 'export ANTHROPIC_API_KEY="$(cat ${osConfig.sops.secrets."api-keys/anthropic".path})"' \
        --run 'export OPENAI_API_KEY="$(cat ${osConfig.sops.secrets."api-keys/openai".path})"' \
    '';
  };
in {
  programs.zed-editor = {
    enable = true;
    package = wrappedZed;

    userSettings = builtins.fromJSON (builtins.readFile ./settings.json);
    userKeymaps = builtins.fromJSON (builtins.readFile ./keymap.json);

    themes = builtins.mapAttrs (name: value: ./themes + ("/" + name)) (builtins.readDir ./themes);
  };

  programs.zed-editor-extensions = {
    enable = true;
    packages = with pkgs.zed-extensions; [
      html
      toml
      java
      sql
      ruby
      latex
      typst
      nix
      mdx
    ];
  };
}
