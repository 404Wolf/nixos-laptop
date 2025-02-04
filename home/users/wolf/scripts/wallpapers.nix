{
  config,
  pkgs,
  ...
}: let
  wallpaper-dir = "${config.xdg.dataHome}/wallpapers";
in {
  fetch-wallpaper =
    pkgs.writeShellScriptBin "fetch-wallpaper"
    # bash
    ''
      WALLPAPER_DIR=${wallpaper-dir}
      MIN_SIZE=2048  # 2KB in bytes

      mkdir -p "$WALLPAPER_DIR"

      URL="http://www.bing.com"$(curl -s "http://www.bing.com/HPImageArchive.aspx?format=js&idx=0&n=50" | jq -r '.images[].url' | head -n1)

      # Download the image to a temporary file
      TEMP_FILE=$(mktemp)
      wget -q "$URL" -O "$TEMP_FILE"

      # Check the file size
      FILE_SIZE=$(stat -f%z "$TEMP_FILE")

      if [ "$FILE_SIZE" -gt "$MIN_SIZE" ]; then
        mv "$TEMP_FILE" "$WALLPAPER_DIR/wallpaper.jpg"
        echo "Downloaded wallpaper from: $URL"
        echo "File size: $FILE_SIZE bytes"
      else
        rm "$TEMP_FILE"
        echo "Downloaded image too small: $FILE_SIZE bytes"
        exit 1
      fi
    '';
}
