{
  config,
  osConfig,
  pkgs,
  system,
  ...
}: let
  mkColor = hash: "rgb(${hash})";
in {
  imports = [
    ./hyprlock.nix
    ./hypridle.nix
    ./hyprpaper.nix
    ./services.nix
  ];

  programs = {
    zsh.initExtra =
      # bash
      ''
        unlock_hyprland() {
          hyprctl --instance 0 'keyword misc:allow_session_lock_restore 1'
          ${pkgs.killall}/bin/killall -9 hyprlock
          hyprctl --instance 0 'dispatch exec hyprlock'
        }
      '';
  };

  wayland.windowManager.hyprland = {
    enable = true;

    systemd.variables = ["--all"];
    xwayland.enable = true;

    settings = {
      source = "~/.config/hypr/monitors.conf";
      exec-once = import ./execs.nix {inherit pkgs config osConfig;};
      animation = [
        "workspaces,1,1,default"
        "windows,1,1,default"
      ];
      env = [
        "QT_QPA_PLATFORM,wayland;xcb"
        "XCURSOR_SIZE,22"
      ];
      # ecosystem = {
      # no_donation_nag = true;
      # };
      general = {
        allow_tearing = false;
        gaps_in = 1;
        gaps_out = 0;
        no_border_on_floating = false;
        border_size = 1;
        resize_on_border = true;
        extend_border_grab_area = 15;
        "col.inactive_border" = mkColor config.colorScheme.palette.base03;
        "col.active_border" = mkColor config.colorScheme.palette.base04;
      };
      decoration = {
        rounding = config.theme.rounding;
        blur.enabled = false;
        shadow.enabled = false;
      };
      group = {
        "col.border_active" = mkColor config.colorScheme.palette.base0A;
        "col.border_inactive" = mkColor config.colorScheme.palette.base03;
        "col.border_locked_active" = mkColor config.colorScheme.palette.base03;
        "col.border_locked_inactive" = mkColor config.colorScheme.palette.base01;
        groupbar = {
          height = 4;
          "col.active" = mkColor config.colorScheme.palette.base09;
          "col.inactive" = mkColor config.colorScheme.palette.base03;
          render_titles = false;
          gradients = false;
          scrolling = true;
        };
      };
      input = {
        repeat_rate = 20; # Repeat rate in ms between key repeats
        repeat_delay = 150; # Delay in ms before key starts repeating
        scroll_button = 274; # 274 = scroll button
        scroll_button_lock = false;
        scroll_method = "on_button_down";
        touchpad.natural_scroll = true;
        kb_options = "caps:numlock";
      };
      gestures = {
        workspace_swipe = true;
        workspace_swipe_fingers = 4;
      };
      misc = {
        vfr = true;
        disable_hyprland_logo = true;
        focus_on_activate = true;
      };
      windowrulev2 = import ./rules.nix {};
    };
    plugins = [
      # pkgs.hyprland-plugins.hyprexpo
    ];
    extraConfig =
      (import ./binds.nix {inherit pkgs system osConfig;})
      + (import ./chords.nix {inherit pkgs;});
  };
}
