{
  program,
  launch,
  kill,
  conditional,
  pkgs,
}:
pkgs.writeShellScriptBin "toggle-${program}.sh" "${conditional} && ${kill} || ${launch}"
