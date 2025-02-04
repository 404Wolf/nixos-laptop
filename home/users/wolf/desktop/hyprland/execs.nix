{
  pkgs,
  config,
}: let
  wallpaper-utils = import ../../scripts/wallpapers.nix {inherit pkgs config;};
in [
  # System/Desktop Environment Setup
  "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
  "${pkgs.waybar}/bin/waybar"
  "${pkgs.hyprpaper}/bin/hyprpaper"
  "${pkgs.hypridle}/bin/hypridle"

  # Wallpaper Management
  "${wallpaper-utils.fetch-wallpaper}/bin/fetch-wallpaper"

  # System Tray Applications
  "${pkgs.blueman}/bin/blueman-applet"
  "${pkgs.networkmanagerapplet}/bin/nm-applet"

  # Communication Apps
  "${pkgs.discord}/bin/discord"
  "${pkgs.signal-desktop}/bin/signal-desktop"
  "${pkgs.zulip}/bin/zulip"
  "${pkgs.whatsapp-for-linux}/bin/whatsapp-for-linux"
  "${pkgs.thunderbird}/bin/thunderbird"

  # Productivity
  "${pkgs.obsidian}/bin/obsidian"
]
