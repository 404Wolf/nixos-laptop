{
  # Nix configuration
  nix.settings = {
    auto-optimise-store = true;
    substituters = [
      "https://hyprland.cachix.org"
      "https://zed.cachix.org"
      "https://cache.garnix.io"
    ];
    trusted-public-keys = [
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
      "zed.cachix.org-1:/pHQ6dpMsAZk2DiP4WCL0p9YDNKWj2Q5FL20bNmw1cU="
      "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
    ];
    trusted-users = [
      "root"
      "wolf"
    ];
    experimental-features = [
      "nix-command"
      "flakes"
    ];
  };
}
