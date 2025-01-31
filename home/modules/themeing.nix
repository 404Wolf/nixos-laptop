{
  pkgs,
  lib,
  ...
}: {
  options = {
    theme = {
      font = {
        package = lib.mkOption {
          type = lib.types.package;
          default = pkgs.fira-code;
          example = pkgs.fira-code;
          description = "Preferred system font";
        };
        name = lib.mkOption {
          type = lib.types.str;
          default = "Fira Code";
          example = "Fira Code";
          description = "Name of font";
        };
        size = lib.mkOption {
          type = lib.types.int;
          default = 12;
          description = "Overall font size";
        };
      };
      rounding = lib.mkOption {
        type = lib.types.int;
        default = 4;
        example = 4;
        description = "Amount of rounding for rounded corners";
      };
    };
  };
}
