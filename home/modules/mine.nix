{lib, ...}: {
  options.my = {
    variables = lib.mkOption {
      type = lib.types.attrsOf lib.types.str;
      default = {};
      description = "Shared general variables";
      example = {
        download-path = "/home/user/Downloads";
      };
    };
    scripts = lib.mkOption {
      type = lib.types.attrsOf lib.types.package;
      default = {};
      description = "Shared scripts for modules";
      example = ''
        {
          backup = pkgs.writeShellScriptBin "backup" '''
            echo "Backing up files..."
            tar -czf backup.tar.gz /home/user/documents
          ''';
          update-mirrors = pkgs.writeShellScriptBin "update-mirrors" '''
            echo "Updating mirror list..."
            reflector --latest 20 --sort rate
          ''';
        }
      '';
    };
  };
}
