{}: let
  presets = {
    chat = [
      "workspace special:3"
      "group set"
    ];
  };
  mkRule = rules: identifierType: identifier: (map (rule: "${rule}, ${identifierType}:${identifier}") rules);
in
  []
  # Get screen sharing for Discord to work
  ++ mkRule [
    "opacity 0.0 override"
    "no_anim on"
    "no_initial_focus on"
    "maxsize 1 1"
    "no_blur on"
  ] "class" "^(xwaylandvideobridge)$"
  # Set custom open in workspace rules
  ++ mkRule ["workspace special:16" "group set"] "class" "obsidian"
  ++ mkRule ["workspace special:20"] "class" "spotify"
  ++ mkRule ["workspace special:21"] "class" "thunderbird"
  ++ mkRule ["workspace special:4"] "class" "remmina"
  ++ mkRule ["workspace special:2"] "class" "Bitwarden"
  # Set up floating apps
  ++ mkRule ["float on" "pin on"] "class" "Qalculate"
  ++ mkRule ["size 40% 33%" "float on"] "class" "sxiv"
  ++ mkRule ["size 60% 70%" "float on" "pin on"] "class" "nemo"
  ++ mkRule ["size 70% 60%" "float on"] "class" "cheese"
  ++ mkRule ["size 60% 70%" "float on"] "class" "zenity"
  ++ mkRule ["size 30% 45%" "float on"] "class" "io.github.Qalculate.qalculate-qt"
  ++ mkRule ["size 30% 60%" "float on" "pin on"] "class" ".blueman-manager-wrapped"
  ++ mkRule ["size 60% 50%" "float on" "pin on"] "class" "nm-connection-editor"
  ++ mkRule ["size 60% 50%" "float on"] "title" "Write: "
  ++ mkRule ["size 60% 50%" "float on" "pin on"] "class" "org.pulseaudio.pavucontrol"
  # Chat app rules
  ++ mkRule presets.chat "class" "discord"
  ++ mkRule presets.chat "class" "signal"
  ++ mkRule presets.chat "class" "Beeper"
  ++ mkRule presets.chat "title" "[zZ]ulip"
  ++ mkRule presets.chat "title" "Voice -"
  ++ mkRule presets.chat "class" "whatsapp-for-linux"
  ++ mkRule presets.chat "class" "Element"
  # Other rules
  ++ mkRule ["suppress_event fullscreen" "suppress_event maximize"] "title" "[lL]ibreoffice"
  ++ mkRule ["float on" "size 85% 70%"] "title" "Untitled - Chromium"
  ++ mkRule ["pin on"] "title" "MainPicker"
