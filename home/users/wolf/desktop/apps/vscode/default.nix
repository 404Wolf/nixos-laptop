{pkgs, ...}: {
  programs.vscode.enable = true;
  programs.vscode.profiles = {
    default = {
      keybindings = import ./keybinds.nix;
      userSettings = (import ./settings.nix) {inherit pkgs;};
      extensions = (import ./extensions.nix) {inherit pkgs;};
    };
  };
}
