{
  pkgs,
  system,
  osConfig,
  ...
}: let
  workspace2d = "${pkgs.hyprland-workspace2d}/bin/workspace2d";

  toggles = let
    toggle = args: (import ./scripts/toggle.nix (args // {inherit pkgs;}));
  in {
    dunst = (import ../../scripts/pause-dunst.nix) {inherit pkgs;};

    remmina = toggle rec {
      program = "remmina";
      launch = let
        remmina-connect = import ../apps/remmina/connect.nix {inherit pkgs osConfig;};
      in "${remmina-connect}/bin/remmina-connect-default.sh";
      kill = "pkill ${program}";
      conditional = "pgrep ${program}";
    };

    spotify = toggle rec {
      program = "spotify";
      launch = "${pkgs.spotify}/bin/spotify";
      kill = "pkill ${program}";
      conditional = "ps aux | grep ${program}";
    };
  };
in
  ''
    $MOD=SUPER_L
    $CAP=MOD2
  ''
  + ''
    # Mouse
    bindm=ALT,mouse:272,movewindow
    bindm=SUPER, mouse:272, resizewindow
  ''
  + ''
    # Audio keybinds
    binde=, XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 4%+   # Increase Volume
    binde=, XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 4%-   # Decrease Volume
    bind=, XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle          # Mute Volume
    bindl=, XF86AudioPlay, exec, ${pkgs.playerctl}/bin/playerctl play-pause         # Pause song
    bindl=, XF86AudioNext, exec, ${pkgs.playerctl}/bin/playerctl next               # Previous song
    bindl=, XF86AudioPrev, exec, ${pkgs.playerctl}/bin/playerctl previous           # Previous song
  ''
  + ''
    # Brightness keybinds
    binde=, XF86MonBrightnessUp, exec, ${pkgs.brightnessctl}/bin/brightnessctl set 10+    # Increase brightness
    binde=, XF86MonBrightnessDown, exec, ${pkgs.brightnessctl}/bin/brightnessctl set 10-  # Decrease brightness
  ''
  + ''
    # Dunst notification toggle
    bind=$CAP ALT SHIFT, D, exec, ${toggles.dunst}/bin/toggle-dunst
  ''
  + ''
    # Waybar keybind
    bind=$SUPER, W, exec, ${pkgs.toybox}/bin/killall -SIGUSR1 waybar
  ''
  + ''
    # Monitor focus keybinds
    bind=$CAP, H, focusmonitor, l
    bind=$CAP, J, focusmonitor, d
    bind=$CAP, K, focusmonitor, u
    bind=$CAP, L, focusmonitor, r
  ''
  + ''
    # Monitor move window keybinds
    bind=$CAP SHIFT, H, movewindow, l
    bind=$CAP SHIFT, J, movewindow, d
    bind=$CAP SHIFT, K, movewindow, u
    bind=$CAP SHIFT, L, movewindow, r
  ''
  + ''
    # Fullscreen keybinds
    bind=$MOD, F11, fullscreen, 0
    bind=$MOD SHIFT, M, fullscreen, 0
    bind=$MOD SHIFT ALT, M, fullscreenstate, 1
    bind=$MOD SHIFT, P, pin, 1
  ''
  + ''
    # Quick launch keybinds

    # Browsers
    bind=$MOD, F, exec, ${pkgs.google-chrome}/bin/google-chrome-stable --profile-directory='Profile 1' --new-window=about:newtab
    bind=$MOD SHIFT, F, exec, ${pkgs.google-chrome}/bin/google-chrome-stable --profile-directory='Default' --new-window=about:newtab
    bind=$MOD ALT, F, exec, ${pkgs.firefox-devedition}/bin/firefox-devedition -profile ~/.mozilla/firefox/default --new-window
    bind=$MOD SHIFT ALT, F, exec, ${pkgs.firefox-devedition}/bin/firefox-devedition -profile ~/.mozilla/firefox/school --new-window
    bind=$MOD CONTROL, F, exec, ${pkgs.qutebrowser}/bin/qutebrowser --target window

    # Apps
    bind=$MOD, T, exec, ${pkgs.kitty}/bin/kitty
    bind=$MOD, C, exec, ${pkgs.qalculate-qt}/bin/qalculate-qt

    # Toggles
    bind=$MOD, D, exec, sh ${toggles.remmina}/bin/toggle-remmina.sh
    bind=$MOD, M, exec, sh ${toggles.spotify}/bin/toggle-spotify.sh
  ''
  + ''
    # App launcher
    bind=$MOD, Space, exec, ${pkgs.fuzzel}/bin/fuzzel
  ''
  + ''
    # Basic app manipulation commands
    bind=$MOD, Y, togglefloating
    bind=$MOD, E, exec, ${pkgs.nemo-with-extensions}/bin/nemo
  ''
  + ''
    # Groups
    bind=$MOD, Q, killactive
    bind=$MOD, S, togglegroup
    bind=$MOD, L, changegroupactive
  ''
  + ''
    # Switch one workspace left/right
    bind=$MOD CONTROL_L, L, exec, ${workspace2d} right "" ""
    bind=$MOD CONTROL_L, H, exec, ${workspace2d} left "" ""
    bind=$MOD CONTROL_L, J, exec, ${workspace2d} down "" ""
    bind=$MOD CONTROL_L, K, exec, ${workspace2d} up "" ""
  ''
  + ''
    bind=$MOD ALT, J, exec, ${workspace2d} down "all" ""
    bind=$MOD ALT, K, exec, ${workspace2d} up "all" ""
  ''
  + ''
    # Move things one workspace left/right
    bind=$MOD SHIFT, L, exec, ${workspace2d} move_right "" ""
    bind=$MOD SHIFT, H, exec, ${workspace2d} move_left "" ""
    bind=$MOD SHIFT, J, exec, ${workspace2d} move_down "" ""
    bind=$MOD SHIFT, K, exec, ${workspace2d} move_up "" ""
  ''
  + ''
    # Lock workspaces
    bind=$MOD ALT, L, lockactivegroup, toggle
    # Pin window
    bind=$MOD, M, pin
  ''
  + ''
    # Scratchpad (special) workspaces
    bind=$CAP, A, togglespecialworkspace, 1
    bind=$CAP, B, togglespecialworkspace, 2
    bind=$CAP, C, togglespecialworkspace, 3
    bind=$CAP, D, togglespecialworkspace, 4
    bind=$CAP, E, togglespecialworkspace, 6
    bind=$CAP, F, togglespecialworkspace, 7
    bind=$CAP, G, togglespecialworkspace, 8
    bind=$CAP, I, togglespecialworkspace, 10
    bind=$CAP, M, togglespecialworkspace, 14
    bind=$CAP, N, togglespecialworkspace, 15
    bind=$CAP, O, togglespecialworkspace, 16
    bind=$CAP, P, togglespecialworkspace, 17
    bind=$CAP, Q, togglespecialworkspace, 18
    bind=$CAP, R, togglespecialworkspace, 19
    bind=$CAP, S, togglespecialworkspace, 20
    bind=$CAP, T, togglespecialworkspace, 21
    bind=$CAP, U, togglespecialworkspace, 22
    bind=$CAP, V, togglespecialworkspace, 23
    bind=$CAP, W, togglespecialworkspace, 24
    bind=$CAP, X, togglespecialworkspace, 25
    bind=$CAP, Y, togglespecialworkspace, 26
    bind=$CAP, Z, togglespecialworkspace, 27


    bind=$CAP SHIFT, A, movetoworkspace, special:1
    bind=$CAP SHIFT, B, movetoworkspace, special:2
    bind=$CAP SHIFT, C, movetoworkspace, special:3
    bind=$CAP SHIFT, D, movetoworkspace, special:4
    bind=$CAP SHIFT, E, movetoworkspace, special:6
    bind=$CAP SHIFT, F, movetoworkspace, special:7
    bind=$CAP SHIFT, G, movetoworkspace, special:8
    bind=$CAP SHIFT, I, movetoworkspace, special:10
    bind=$CAP SHIFT, M, movetoworkspace, special:14
    bind=$CAP SHIFT, N, movetoworkspace, special:15
    bind=$CAP SHIFT, O, movetoworkspace, special:16
    bind=$CAP SHIFT, P, movetoworkspace, special:17
    bind=$CAP SHIFT, Q, movetoworkspace, special:18
    bind=$CAP SHIFT, R, movetoworkspace, special:19
    bind=$CAP SHIFT, S, movetoworkspace, special:20
    bind=$CAP SHIFT, T, movetoworkspace, special:21
    bind=$CAP SHIFT, U, movetoworkspace, special:22
    bind=$CAP SHIFT, V, movetoworkspace, special:23
    bind=$CAP SHIFT, W, movetoworkspace, special:24
    bind=$CAP SHIFT, X, movetoworkspace, special:25
    bind=$CAP SHIFT, Y, movetoworkspace, special:26
    bind=$CAP SHIFT, Z, movetoworkspace, special:27
  ''
  + ''
    # Easily get to obsidian
    bind=$MOD, O, exec, hyprctl dispatch workspace special:16 & [ ps aux | grep '[o]bsidian' || ${pkgs.obsidian}/bin/obsidian ]
  ''
  + ''
    # Changing window focus
    bind=$MOD, H, movefocus, l
    bind=$MOD, K, movefocus, u
    bind=$MOD, J, movefocus, d
    bind=$MOD, L, movefocus, r
  ''
  + ''
    # Changing focus within a group
    bind=$MOD, Tab, changegroupactive, f
    bind=$MOD Shift, Tab, changegroupactive, b
    bind=$MOD $CAP, Z, changegroupactive, 1
    bind=$MOD $CAP, X, changegroupactive, 2
    bind=$MOD $CAP, C, changegroupactive, 3
    bind=$MOD $CAP, V, changegroupactive, 4
    bind=$MOD $CAP, B, changegroupactive, 5
    bind=$MOD $CAP, N, changegroupactive, 6
    bind=$MOD $CAP, M, changegroupactive, 7
  ''
  + ''
    # Moving windows within a group
    bind=$MOD, code:192 L, moveactive, f
    bind=$MOD, code:192 H, moveactive, b
  ''
  + ''
    # Toggle Mode Submap
    bind=$MOD, Return, submap, toggle
    submap=toggle
    $amount=40

    # Resizing commands
    binde=$CAP, L, resizeactive, $amount 0
    binde=$CAP, H, resizeactive, -$amount 0
    binde=$CAP, K, resizeactive, 0 -$amount
    binde=$CAP, J, resizeactive, 0 $amount

    # Yoinking windows out
    bind=$MOD SHIFT, L, moveintogroup, r
    bind=$MOD SHIFT, K, moveintogroup, u
    bind=$MOD SHIFT, J, moveintogroup, d
    bind=$MOD SHIFT, H, moveintogroup, l

    # Yoinking windows in
    bind=$MOD, L, exec, hyprctl dispatch moveoutofgroup && hyprctl dispatch movewindow r
    bind=$MOD, K, exec, hyprctl dispatch moveoutofgroup && hyprctl dispatch movewindow u
    bind=$MOD, J, exec, hyprctl dispatch moveoutofgroup && hyprctl dispatch movewindow d
    bind=$MOD, H, exec, hyprctl dispatch moveoutofgroup && hyprctl dispatch movewindow l

    # Escaping the submap
    bind=, escape, submap, reset
    bind=, Return, submap, reset
    bind=,catchall,submap,reset
    submap=reset
  ''
  + ''
    # Clipboard history
    bind=$MOD, V, exec, ${pkgs.cliphist}/bin/cliphist list | fuzzel --dmenu | ${pkgs.cliphist}/bin/cliphist decode | ${pkgs.wl-clipboard}/bin/wl-copy
  ''
