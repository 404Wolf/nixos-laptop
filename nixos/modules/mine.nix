{lib, ...}: {
  options.my = {
    variables = lib.mkOption {
      type = lib.types.attrsOf lib.types.str;
      default = {};
      description = "Shared general variables";
    };
  };

  config.my = {
    variables = {
      airpods-mac = "74:15:F5:5B:5E:DE";
    };
  };
}
