{pkgs, ...}: {
  programs.vscode = {
    enable = true;
    package = pkgs.vscode;
    keybindings = import ./keybinds.nix;
    userSettings = (import ./settings.nix) {inherit pkgs;};
    extensions = (import ./extensions.nix) {inherit pkgs;};
  };
}
