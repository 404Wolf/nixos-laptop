{machine}: {
  imports =
    if machine == "framework"
    then [
      ./fuzzel.nix
      ./dunst.nix
      ./hyprland
      ./waybar
      ./tofi
      ./apps
      ./gtk.nix
      ./xdg.nix
      ./zed.nix
    ]
    else [
      ./apps
    ];
}
