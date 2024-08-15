{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs?dir=lib";

  outputs =
    inputs:
    let
      lib = import ./lib { lib0 = inputs.nixpkgs.lib; };
    in
    {
      inherit lib;

      nixosModules.default = import ./modules/system { inherit lib; };
      homeManagerModules.default = import ./modules/home { inherit lib; };
    };
}
