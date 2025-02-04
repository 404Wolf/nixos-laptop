{pkgs, ...}: {
  # User account
  users = {
    defaultUserShell = pkgs.zsh;
    users = {
      wolf = {
        password = "password";
        description = "Wolf Mermelstein";
        extraGroups = ["wheel"];
        isNormalUser = true;
      };
    };
  };
}
