{
  pkgs,
  machine,
  ...
}: {
  home.packages =
    with pkgs;
    [
      # System Utilities
      curl
      bat
      wget
      uv
      tree
      tmux
      sshfs
      openssl
      yubikey-agent
      yubikey-manager
      cmake
      htop
      cloudflared
      speedtest-cli
      monolith
      sops
      killall
      lsof
      traceroute
      dig
      binsider
      just
      trash-cli

      # Networking & File Management
      rclone
      xdg-utils
      magic-wormhole

      # Development & Programming Tools
      claude-code
      gcc
      hyperfine
      ast-grep
      cargo
      delve
      pkg-config
      gnumake
      nodejs_24
      deno
      bun
      sd
      mise
      go
      (python3.withPackages (
        pyPkgs:
          with pyPkgs; [
            numpy
            pandas
            pytest
            pip
          ]
      ))
      typst
      lazygit
      delta
      yubioath-flutter
      texliveFull
      pandoc
      code-cursor
      otree
      appimage-run

      # Text Processing & File Manipulation
      ripgrep
      jq
      fzf
      fd
      perlPackages.FileMimeInfo
      pdftk
      unzip
      zip
      dtrx

      # Monitoring & Analysis
      tokei
      nix-tree
      entr
      nmap
      spotify
      spotube

      # Productivity & Documentation
      tldr
      wrappedNvim
      libreoffice-qt6-still
      onlyoffice-desktopeditors
      zotero
      anki
      evince
      rcu # remarkable connection utility
      obsidian
      obsidian-export

      # Graphics & Media
      gimp
      inkscape
      obs-studio
      vlc
      mpv

      # Browsers & Communication
      google-chrome
      brave
      ungoogled-chromium
      vesktop
      zulip
      zoom-us
      signal-desktop
      wasistlos
      hoppscotch
      beeper

      # Security & Password Management
      bitwarden-desktop
      rbw

      # Database Tools
      sqlitebrowser
      gpgme
    ]
    ++ (
      if machine == "framework"
      then
        with pkgs;
        [
          dhcpcd
          util-linux
          exfat
          bluez
          wl-clipboard
          brightnessctl
          playerctl
          cpulimit
          cliphist
          usbutils
          pciutils
          udiskie
          librepods
          gdb
          acpi
          powertop
          feh
          grim
          slurp
          nwg-displays
          hyprpicker
          pulseaudio
        ]
      else []
    );
}
