[
  (final: prev: {
    kitty = prev.symlinkJoin {
      name = "kitty-wrapped";
      paths = [prev.kitty];
      buildInputs = [prev.makeWrapper];
      postBuild = ''
        wrapProgram $out/bin/kitty \
          --run 'export TMP_DIR=$(mktemp -d)' \
          --add-flags '--directory $TMP_DIR'
      '';
    };
  })
]
