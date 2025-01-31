{pkgs, ...}: {
  "name" = "peek";
  "layer" = "top";
  "position" = "bottom";
  "exclusive" = false;
  "modules-right" = ["clock"];
  "modules-left" = ["battery"];
  "clock" = {
    "format" = "{:%I:%M:%S %p}";
    "interval" = 1;
    "format-alt" = "{:%m/%d %a %T}";
  };
  "battery" = {
    "states" = {
      "good" = 95;
      "warning" = 30;
      "critical" = 15;
    };
    "format" = "{capacity}% {icon}";
    "format-full" = "{capacity}% {icon}";
    "format-charging" = "{capacity}% ⚡";
    "format-plugged" = "{capacity}% ";
    "format-alt" = "{time} {icon}";
    "format-icons" = [
      ""
      ""
      ""
      ""
      ""
    ];
  };
}
