{
  pkgs,
  config,
  osConfig,
}: let
  uwsm-start-app = pkgs.writeShellScriptBin "uwsm-start-app" ''
    ${pkgs.waybar}/bin/waybar &
    ${pkgs.hyprpaper}/bin/hyprpaper &
    ${pkgs.hypridle}/bin/hypridle &
    ${pkgs.blueman}/bin/blueman-applet &
    ${pkgs.networkmanagerapplet}/bin/nm-applet &
    ${pkgs.obsidian}/bin/obsidian &
    ${pkgs.beeper}/bin/beeper &
    ${pkgs.thunderbird}/bin/thunderbird &
    ${pkgs.wl-clipboard}/bin/wl-paste --type text --watch ${pkgs.cliphist}/bin/cliphist store &
    ${pkgs.wl-clipboard}/bin/wl-paste --type image --watch ${pkgs.cliphist}/bin/cliphist store &
    ${pkgs.hyprpolkitagent}/libexec/hyprpolkitagent &
    ${pkgs.udiskie}/bin/udiskie --tray --notify --automount &
  '';
in "uwsm app -- ${uwsm-start-app}/bin/uwsm-start-app"
