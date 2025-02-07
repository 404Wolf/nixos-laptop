{
  pkgs,
  config,
}: [
  # System/Desktop Environment Setup
  "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
  "${pkgs.curl}/bin/curl -L https://wolf-fetchbingimageoftheday.web.val.run -o ${config.xdg.dataHome}/wallpapers/wallpaper.jpg"
  "${pkgs.waybar}/bin/waybar"
  "${pkgs.hyprpaper}/bin/hyprpaper"
  "${pkgs.hypridle}/bin/hypridle"

  # System Tray Applications
  "${pkgs.blueman}/bin/blueman-applet"
  "${pkgs.networkmanagerapplet}/bin/nm-applet"

  # Productivity
  "${pkgs.obsidian}/bin/obsidian"
]
