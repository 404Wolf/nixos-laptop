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
  ''
    ${pkgs.curl}/bin/curl -L https://wolf-fetchbingimageoftheday.web.val.run -o ${config.xdg.dataHome}/wallpapers/wallpaper.jpg && \
    ${pkgs.hyprpaper}/bin/hyprpaper
  ''

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

  # Start Kitty in special workspace 8 running gpt cheap-claude
  "hyprctl dispatch exec \"[workspace special:8] kitty sh -c 'ANTHROPIC_API_KEY=$(cat ${osConfig.sops.secrets."api-keys/anthropic".path}) ${pkgs.nixGpt}/bin/gpt'\""
]
