{
  pkgs,
  config,
  osConfig,
}: [
  # Initialize DBus environment variables for Wayland
  "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"

  # Start Waybar status bar
  "${pkgs.waybar}/bin/waybar"

  # Fetch daily Bing wallpaper and start wallpaper daemon
  "sh -c '${pkgs.writeShellScript "refresh-wallpaper" config.my.scripts.wallpaper-refresh}'"

  # Start idle daemon
  "${pkgs.hypridle}/bin/hypridle"

  # Start Bluetooth manager applet
  "${pkgs.blueman}/bin/blueman-applet"

  # Start NetworkManager applet
  "${pkgs.networkmanagerapplet}/bin/nm-applet"

  # Start Obsidian note-taking app
  "${pkgs.obsidian}/bin/obsidian"

  # Start Beeper messaging client
  "${pkgs.beeper}/bin/beeper"

  # Start Thunderbird email client
  "${pkgs.thunderbird}/bin/thunderbird"

  # Clipboard managemer
  "${pkgs.wl-clipboard}/bin/wl-paste --type text --watch ${pkgs.cliphist}/bin/cliphist store" # Stores only text data
  "${pkgs.wl-clipboard}/bin/wl-paste --type image --watch ${pkgs.cliphist}/bin/cliphist store" # Stores only image data

  # Pollkit
  "${pkgs.hyprpolkitagent}/libexec/hyprpolkitagent"
]
