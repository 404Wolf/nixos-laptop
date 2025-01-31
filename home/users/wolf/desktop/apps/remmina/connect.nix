{
  config,
  pkgs,
}:
pkgs.writeShellApplication {
  name = "remmina-connect-default.sh";
  runtimeInputs = [pkgs.remmina];
  text = ''
    REMMINA_CONNECTION_FILENAME="$(uuidgen).remmina"
    cp ${./config-files/default.remmina} "/tmp/$REMMINA_CONNECTION_FILENAME"
    echo "password=${config.sops.placeholder.remotes.windows.password}" >> /tmp/$REMMINA_CONNECTION_FILENAME
    remmina "/tmp/$REMMINA_CONNECTION_FILENAME"
  '';
}
