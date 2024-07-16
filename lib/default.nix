# following https://github.com/NixOS/nixpkgs/blob/77ee426a4da240c1df7e11f48ac6243e0890f03e/lib/default.nix
# as a rough template we can create our own extensible lib and expose it to the flake
# we can then use that elsewhere like our hosts
{ lib0 }:
let
  sprout = lib0.makeExtensible (
    self:
    let
      callLib = file: import file { lib = self; };
      filesets = callLib ./filesets.nix;
      umport = callLib ./umport.nix;
      helpers = callLib ./helpers.nix;
      strings = callLib ./strings.nix;
    in
      filesets // umport // helpers // strings
  );

  # we need to extend gardenLib with the nixpkgs lib to get the full set of functions
  # if we do it the otherway around we will get errors saying mkMerge and so on don't exist
  finalLib = sprout.extend (_: _: lib0);
in
finalLib
