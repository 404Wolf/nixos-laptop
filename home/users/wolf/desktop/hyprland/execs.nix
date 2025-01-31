{pkgs}: let
  wallpaper-utils = import ../../scripts/wallpapers.nix {inherit pkgs;};
in [
  "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
  "${wallpaper-utils.fetch-wallpaper}/bin/fetch-wallpaper.sh"
  "${wallpaper-utils.choose-wallpaper}/bin/choose-wallpaper.sh"
  "${pkgs.hypridle}/bin/hypridle"
  "${pkgs.waybar}/bin/waybar"
  "${pkgs.blueman}/bin/blueman-applet"
  "${pkgs.hyprpaper}/bin/hyprpaper"
  "${pkgs.obsidian}/bin/obsidian"
  "${pkgs.discord}/bin/discord"
  "${pkgs.signal-desktop}/bin/signal-desktop"
  "${pkgs.zulip}/bin/zulip"
  "${pkgs.whatsapp-for-linux}/bin/whatsapp-for-linux"
  "${pkgs.thunderbird}/bin/thunderbird"
  "${pkgs.networkmanagerapplet}/bin/nm-applet"
  "hyprctl dispatch \"exec [workspace special:8] kitty -e ${pkgs.nixGpt}/bin/gptcli cheap-claude\""
  "hyprctl dispatch \"exec [workspace special:15] kitty -e 'cd ~/Config/NixOS tmns nix-config'"
]
