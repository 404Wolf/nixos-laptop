{pkgs, ...}: {
  home.packages = with pkgs; [
    # System Utilities
    curl
    bat
    wget
    tree
    dhcpcd
    tmux
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
    ungoogled-chromium
    usbutils
    pciutils
    udiskie
    monolith
    sops
    killall

    # Networking & File Management
    rclone
    xdg-utils
    magic-wormhole

    # Development & Programming Tools
    gcc
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
    (python3.withPackages (pyPkgs:
      with pyPkgs; [
        numpy
        pandas
        pytest
        pip
      ]))
    typst
    lazygit
    delta
    valfs
    yubioath-flutter
    texliveFull
    pandoc
    code-cursor
    otree

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
    cloc
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

    # Browsers & Communication
    google-chrome
    (discord.override {
      withOpenASAR = true;
      withVencord = true;
    })
    zulip
    zoom-us
    signal-desktop
    whatsapp-for-linux
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
