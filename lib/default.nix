# following https://github.com/NixOS/nixpkgs/blob/77ee426a4da240c1df7e11f48ac6243e0890f03e/lib/default.nix
# as a rough template we can create our own extensible lib and expose it to the flake
# we can then use that elsewhere like our hosts
{ lib0 }:
let
  sprout = lib0.makeExtensible (
    self:
    let
      # this allows us to call lib with a reliance on itself
      # it also saves us repeating the same import line over and over
      callLib = file: import file { lib = self; };
    in
    {
      sprout = {
        helpers = callLib ./helpers.nix;
        options = callLib ./options.nix;
        strings = callLib ./strings.nix;

        inherit (self.sprout.helpers) giturl;
        inherit (self.sprout.options)
          mkOpt
          mkOpt'
          mkBoolOpt
          mkBoolOpt'
          mkEnableOpt
          mkOptions
          enabled
          disabled
          use
          ;
        inherit (self.sprout.strings) mkUpper containsStrings;
      };
    }
  );
in
sprout.extend (_: _: lib0)
