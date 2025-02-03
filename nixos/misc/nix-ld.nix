{pkgs, ...}: {
  programs.nix-ld = {
    enable = true;

    libraries = with pkgs; [
      glib # Low-level core library for GNOME projects
      openssl # Cryptography and SSL/TLS toolkit
      zlib # Compression library
      bzip2 # High-quality data compression program
      libxml2 # XML parsing library
      readline # Library for command-line editing
      ncurses # Free software emulation of curses
      cairo # Vector graphics library
      freetype # Font rendering library
      fontconfig # Font configuration and customization library
      libffi # Foreign function interface library
    ];
  };
}
