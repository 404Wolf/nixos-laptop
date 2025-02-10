{
  pkgs,
  scripts,
  ...
}: {
  name = "main";
  "layer" = "top";
  "position" = "top";
  "start_hidden" = true;
  "exclusive" = true;
  "modules-left" = [
    "hyprland/workspaces"
    "cpu"
    "memory"
    "custom/cpugovernor"
    "custom/weather"
    "tray"
  ];
  "modules-center" = ["clock"];
  "modules-right" = [
    "network"
    "pulseaudio"
    "backlight"
    "battery"
  ];
  "hyprland/workspaces" = {
    "format" = "{name}";
    "show-special" = false;
  };
  "backlight" = {
    "format" = "{percent}% {icon}";
    "format-icons" = ["" "" "" "" "" "" "" "" ""];
  };
  "network" = {
    "format-wifi" = "{essid} ({signalStrength}%)  ";
    "format-ethernet" = "{ifname} ";
    "format-disconnected" = "";
    "max-length" = 50;
    "on-click" = "${pkgs.networkmanagerapplet}/bin/nm-connection-editor";
  };
  "mpris" = {
    "player" = "${pkgs.playerctl}/bin/playerctl";
    "format" = "{player_icon} {dynamic}";
    "format-paused" = "{status_icon} <i>{dynamic}</i>";
    "player-icons" = {
      "default" = "▶";
      "mpv" = "🎵";
    };
    "status-icons" = {
      "paused" = "⏸";
    };
  };
  "custom/weather" = {
    "format" = "{}°";
    "tooltip" = true;
    "interval" = 60;
    "exec" = "${pkgs.wttrbar}/bin/wttrbar --fahrenheit --mph";
    "return-type" = "json";
  };
  "tray" = {
    "icon-size" = 15;
    "spacing" = 10;
  };
  "clock" = {
    "tooltip-format" = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
    "format" = "{:%m/%d %a %T}";
    "interval" = 1;
    "format-alt" = "{:%m/%d %a %T}";
  };
  "pulseaudio" = {
    "format" = "{volume}% {icon} ";
    "format-bluetooth" = "{volume}% {icon} {format_source}";
    "format-bluetooth-muted" = " {icon} {format_source}";
    "format-muted" = "0% {icon} ";
    "format-source" = "{volume}% ";
    "format-source-muted" = "";
    "format-icons" = {
      "headphone" = "";
      "hands-free" = "";
      "headset" = "";
      "phone" = "";
      "portable" = "";
      "car" = "";
      "default" = ["" "" ""];
    };
    "on-click" = "pavucontrol";
  };
  "bluetooth" = {
    "format" = " {status}";
    "format-connected" = " {num_connections} connected";
    "tooltip-format" = "{controller_alias}\t{controller_address}";
    "tooltip-format-connected" = "{controller_alias}\t{controller_address}\n\n{device_enumerate}";
    "tooltip-format-enumerate-connected" = "{device_alias}\t{device_address}";
  };
  "battery" = {
    "states" = {
      "good" = 90;
      "warning" = 30;
      "critical" = 15;
    };
    "format" = "{capacity}% {icon}";
    "format-full" = "{capacity}% {icon}";
    "format-charging" = "{capacity}% ⚡ {icon}";
    "format-plugged" = "{capacity}% {icon}";
    "format-icons" = ["" "" "" "" ""];
    "tooltip-format" = "{time}";
    "tooltip-format-charging" = "Charging\nPower: {power}W\nTime until full: {time}";
  };
  "custom/cpugovernor" = {
    format = "{}";
    interval = 5;
    "return-type" = "json";
    exec = "${scripts.getCpuGovernor}";
    tooltip = true;
    "on-click" = "${scripts.toggleCpuGovernor}";
  };
}
