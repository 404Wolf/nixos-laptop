{pkgs, ...}: {
  home.packages = with pkgs; [
    # System Utilities
    curl
    bat
    wget
    tree
    dhcpcd
    util-linux
    exfat
    sshfs
    openssl
    yubikey-agent
    yubikey-manager
    cmake
    htop
    cloudflared
    speedtest-cli
    bluez
    wl-clipboard
    brightnessctl
    playerctl
    cpulimit
    cliphist
    usbutils
    pciutils
    udiskie
    monolith
    sops
    killall
    lsof
    traceroute
    dig
    librepods
    binsider
    just
    trash-cli

    # Networking & File Management
    rclone
    xdg-utils
    magic-wormhole

    # Development & Programming Tools
    gcc
    ast-grep
    cargo
    delve
    gdb
    pkg-config
    gnumake
    nodejs_20
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
    acpi
    powertop
    nmap
    spotify
    spotube

    # Productivity & Documentation
    tldr
    wrappedNvim
    libreoffice-qt6-still
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
    feh
    grim
    slurp
    nwg-displays
    hyprpicker
    pulseaudio

    # Browsers & Communication
    google-chrome
    brave
    ungoogled-chromium
    (discord.override {
      withOpenASAR = true;
      withVencord = true;
    })
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
  ];
}
