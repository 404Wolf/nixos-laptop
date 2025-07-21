{
  pkgs,
  inputs,
  ...
}: {
  programs.vscode = {
    enable = true;
    keybindings = import ./keybinds.nix;
    userSettings = (import ./settings.nix) {inherit pkgs;};
    extensions = (import ./extensions.nix) {
      inherit pkgs;
      fenix = inputs.fenix;
    };
  };
}
