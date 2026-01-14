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
  ++ mkRule ["opacity 0.0 override"] "class" "^(xwaylandvideobridge)$"
  ++ mkRule ["noanim"] "class" "^(xwaylandvideobridge)$"
  ++ mkRule ["noinitialfocus"] "class" "^(xwaylandvideobridge)$"
  ++ mkRule ["maxsize 1 1"] "class" "^(xwaylandvideobridge)$"
  ++ mkRule ["noblur"] "class" "^(xwaylandvideobridge)$"
  # Set custom open in workspace rules
  ++ mkRule ["workspace special:16" "group set"] "class" "obsidian"
  ++ mkRule ["workspace special:20"] "class" "spotify"
  ++ mkRule ["workspace special:21"] "class" "thunderbird"
  ++ mkRule ["workspace special:4"] "class" "remmina"
  ++ mkRule ["workspace special:2"] "class" "Bitwarden"
  # Set up floating apps
  ++ mkRule ["float" "pin"] "class" "Qalculate"
  ++ mkRule ["size 40% 33%" "float"] "class" "sxiv"
  ++ mkRule ["size 60% 70%" "float" "pin"] "class" "nemo"
  ++ mkRule ["size 70% 60%" "float"] "class" "cheese"
  ++ mkRule ["size 60% 70%" "float"] "class" "zenity"
  ++ mkRule ["size 30% 45%" "float"] "class" "io.github.Qalculate.qalculate-qt"
  ++ mkRule ["size 30% 60%" "float" "pin"] "class" ".blueman-manager-wrapped"
  ++ mkRule ["size 30% 60%" "pin" "float"] "class" ".blueman-manager-wrapped"
  ++ mkRule ["size 60% 50%" "float" "pin"] "class" "nm-connection-editor"
  ++ mkRule ["size 60% 50%" "float"] "title" "Write: "
  ++ mkRule ["size 60% 50%" "float" "pin"] "class" "org.pulseaudio.pavucontrol"
  # Chat app rules
  ++ mkRule presets.chat "class" "discord"
  ++ mkRule presets.chat "class" "signal"
  ++ mkRule presets.chat "class" "Beeper"
  ++ mkRule presets.chat "title" "[zZ]ulip"
  ++ mkRule presets.chat "title" "Voice -"
  ++ mkRule presets.chat "class" "whatsapp-for-linux"
  ++ mkRule presets.chat "class" "Fractal"
  # Other rules
  ++ mkRule ["suppressevent fullscreen" "suppressevent maximize"] "title" "[lL]ibreoffice"
  ++ mkRule ["float" "size 85% 70%"] "title" "Untitled - Chromium"
  ++ mkRule ["pin"] "title" "MainPicker"
