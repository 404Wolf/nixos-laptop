[
  # Get screen sharing for Discord to work
  "match:class ^(xwaylandvideobridge)$, opacity 0 override no_anim no_initial_focus no_blur"
]
# General workspace rules
++ [
  "match:class spotify (workspace special:20)"
  "match:class thunderbird (workspace special:21)"
  "match:class remmina (workspace special:4)"
  "match:class Bitwarden (workspace special:2)"
]
# Set up floating apps
++ [
  "match:class Qalculate float pin"
  "match:class sxiv (size 40% 33%) float"
  "match:class nemo (size 60% 70%) float pin"
  "match:class cheese (size 70% 60%) float"
  "match:class zenity (size 60% 70%) float"
  "match:class io.github.Qalculate.qalculate-qt (size 30% 45%) float"
  "match:class .blueman-manager-wrapped (size 30% 60%) float pin"
  "match:class nm-connection-editor (size 60% 50%) float pin"
  "match:title Write:  (size 60% 50%) float"
  "match:class org.pulseaudio.pavucontrol (size 60% 50%) float pin"
]
# Chat app rules
++ (
  let
    chat-rules = "(workspace special:3) (group set)";
  in [
    "match:class discord ${chat-rules}"
    "match:class vesktop ${chat-rules}"
    "match:class signal ${chat-rules}"
    "match:class Beeper ${chat-rules}"
    "match:title [zZ]ulip ${chat-rules}"
    "match:title Voice ${chat-rules}"
    "match:class whatsapp-for-linux ${chat-rules}"
    "match:class Fractal ${chat-rules}"
  ]
)
++ [
  "match:title [lL]ibreoffice suppressevent fullscreen suppressevent maximize"
  "match:title Untitled - Chromium float (size 85% 70%)"
  "match:title MainPicker pin"
]
++ [
  "match:title .*_centersmall$ float (size 50% 50%) center pin"
]
