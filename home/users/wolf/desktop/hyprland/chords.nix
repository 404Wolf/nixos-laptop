{pkgs}: let
  mkSubmap = {
    name,
    bind,
    body,
  }: ''
    # Toggle Submap
    bind=${bind}, submap, ${name}

    # Following declarations will be for the submap
    submap=${name}

    ${body}

    # Escaping the submap
    bind=, catchall, submap, reset

    # Resetting the submap for future commands
    submap=reset
  '';
in
  mkSubmap {
    name = "launchers";
    bind = "$MOD, L";
    body = ''
      bind=, B, exec, ${pkgs.blueman}/bin/blueman-manager
      bind=, A, exec, ${pkgs.pavucontrol}/bin/pavucontrol
    '';
  }
  + mkSubmap {
    name = "capture";
    bind = "$MOD SHIFT, S";
    body = ''
      bind=, G, exec, sh -c '${pkgs.capture-utils}/bin/screen-capture gif'
      bind=, V, exec, sh -c '${pkgs.capture-utils}/bin/screen-capture video'
      bind=, S, exec, sh -c '${pkgs.capture-utils}/bin/screen-capture image'
      bind=, D, exec, SCREENSHOT_DELAY=3 ${pkgs.capture-utils}/bin/screen-capture image
    '';
  }
  + mkSubmap {
    name = "power";
    bind = "$MOD SHIFT, P";
    body = ''
      bind=, H, exec, systemctl hibernate
    '';
  }
  + mkSubmap {
    name = "windowManipulate";
    bind = "$MOD, Return";
    body = ''
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
    '';
  }
