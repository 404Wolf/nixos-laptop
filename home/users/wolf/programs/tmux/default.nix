{
  pkgs,
  config,
  helpers,
  ...
}: {
  programs.tmux = {
    enable = true;
    terminal = "screen-256color";
    shortcut = "a";
    keyMode = "vi";
    plugins = with pkgs.tmuxPlugins; [
      better-mouse-mode
      vim-tmux-navigator
      yank
    ];
    extraConfig =
      # bash
      ''
        # Begin window count at 1
        set -g base-index 1

        # Put the status line on the top
        set-option -g status-position top

        set -sg escape-time 0
        run-shell "${pkgs.powerline}/bin/powerline-daemon -q"

        set-environment -g PATH "$PATH:${pkgs.powerline}/bin"
        source ${pkgs.powerline}/share/tmux/powerline_tmux_1.9_plus.conf

        setw -g mouse on

        # set vi-mode
        set-window-option -g mode-keys vi
        set -g status-keys vi
        setw -g mode-keys vi

        # vi keybindings
        bind h select-pane -L
        bind j select-pane -D
        bind k select-pane -U
        bind l select-pane -R

        # Stay in same directory when split
        bind | split-window -h -c "#{pane_current_path}"
        bind - split-window -v -c "#{pane_current_path}"

        # Be faster switching windows
        bind C-n next-window
        bind C-p previous-window

        # Force true colors
        set-option -ga terminal-overrides ",*:Tc"

        set-option -g mouse on
        set-option -g focus-events on

        # Make it so escape forwards instantly for vim
        set -sg escape-time 0

        # Control a, control c, to change the working directory
        bind C-c command-prompt -p "New working directory:" "attach -c '%%'"
      ''
      + (helpers.template ./template.mustache config.colorScheme.palette);
  };
}
