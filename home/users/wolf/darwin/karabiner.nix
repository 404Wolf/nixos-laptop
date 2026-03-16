{ lib, ... }:
let
  keys = [
    "a" "b" "c" "d" "e" "f" "g" "h" "i" "j" "k" "l" "m"
    "n" "o" "p" "q" "r" "s" "t" "u" "v" "w" "x" "y" "z"
    "1" "2" "3" "4" "5" "6" "7" "8" "9" "0"
    "minus" "equal" "semicolon" "quote" "comma" "period" "slash"
    "left_bracket" "right_bracket" "backslash" "grave_accent_and_tilde"
  ];

  mkRule = mods: key: {
    type = "basic";
    from = {
      key_code = key;
      modifiers = {
        mandatory = mods;
        optional = [];
      };
    };
    to = [{ key_code = key; modifiers = mods; }];
  };
in
{
  home.file.".config/karabiner/karabiner.json".text = builtins.toJSON {
    global = {
      check_for_updates_on_startup = false;
      show_in_menu_bar = false;
    };
    profiles = [{
      name = "Default profile";
      selected = true;
      simple_modifications = [];
      devices = [];
      complex_modifications.rules = [{
        description = "Make option a pure modifier (no Unicode characters)";
        manipulators =
          (map (mkRule ["option"]) keys) ++
          (map (mkRule ["option" "shift"]) keys);
      }];
      virtual_hid_keyboard.keyboard_type_v2 = "ansi";
    }];
  };
}
