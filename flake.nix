{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs?dir=lib";

  outputs =
    { nixpkgs, ... }:
    let
      lib = import ./lib { lib0 = nixpkgs.lib; };
    in
    {
      inherit lib;

      nixosModules.default = import ./modules/system { inherit lib; };
      homeManagerModules.default = import ./modules/home { inherit lib; };
    };
}
