{
  osConfig,
  pkgs,
}: let
  windowsPasswordFile = osConfig.sops.secrets."remotes/windows/password".path;
in
  pkgs.writeShellApplication {
    name = "remmina-connect-default.sh";
    runtimeInputs = [pkgs.remmina];
    text = ''
      REMMINA_CONNECTION_FILENAME="$(uuidgen).remmina"
      cp ${./config-files/default.remmina} "/tmp/$REMMINA_CONNECTION_FILENAME"
      echo "password=$(cat ${windowsPasswordFile})" >> "/tmp/$REMMINA_CONNECTION_FILENAME"
      remmina "/tmp/$REMMINA_CONNECTION_FILENAME"
    '';
  }
