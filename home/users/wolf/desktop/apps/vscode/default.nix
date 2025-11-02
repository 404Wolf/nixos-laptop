{pkgs, ...}: {
  programs.vscode = {
    enable = true;
    profiles = {
      default = {
        enableUpdateCheck = false;
        keybindings = import ./keybinds.nix;
        userSettings = (import ./settings.nix) {inherit pkgs;};
        extensions = (import ./extensions.nix) {inherit pkgs;};
      };
    };
  };
}
