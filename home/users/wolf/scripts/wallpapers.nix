{pkgs, ...}: let
  wallpaper-dir = "$HOME/.background-images";
in {
  fetch-wallpaper =
    pkgs.writeShellScriptBin "fetch-wallpaper.sh"
    # bash
    ''
      TIMEOUT=3600
      WALLPAPER_DIR=${wallpaper-dir}
      URL="http://www.bing.com"$(curl -s "http://www.bing.com/HPImageArchive.aspx?format=js&idx=0&n=50" | jq -r '.images[].url' | head -n1)
      mkdir -p "$WALLPAPER_DIR"

      while [ true ]; do
        if ping -q -c 1 -W 1 8.8.8.8 >/dev/null; then
          if wget -q "$URL" -O "$WALLPAPER_DIR/$(date +%Y%m%d%H%M%S).jpg"; then
            TIMEOUT=3600
          else
            TIMEOUT=300
          fi
        else
          TIMEOUT=300
        fi
        sleep $TIMEOUT
      done
    '';
  choose-wallpaper =
    pkgs.writeShellScriptBin "choose-wallpaper.sh"
    # bash
    ''
      WALLPAPER_DIR=${wallpaper-dir}
      MIN_SIZE=2048  # 2KB in bytes

      while true; do
        CHOSEN_WALLPAPER=$(find "$WALLPAPER_DIR" -type f | shuf -n 1)

        if [ -n "$CHOSEN_WALLPAPER" ]; then
          FILE_SIZE=$(stat -f%z "$CHOSEN_WALLPAPER")

          if [ "$FILE_SIZE" -gt "$MIN_SIZE" ]; then
            cp "$CHOSEN_WALLPAPER" "$WALLPAPER_DIR/wallpaper.jpg"
            echo "Selected wallpaper: $CHOSEN_WALLPAPER"
            echo "File size: $FILE_SIZE bytes"
            break
          else
            echo "Skipping $CHOSEN_WALLPAPER (size: $FILE_SIZE bytes)"
          fi
        else
          echo "No wallpapers found in $WALLPAPER_DIR"
          exit 1
        fi
      done
    '';
}
