{
  inputs.nixpkgs.url = "github:NixOS/nixpkgs?dir=lib";

  outputs =
    { nixpkgs, ... }:
    {
      lib = import ./lib { lib0 = nixpkgs.lib; };
    };
}
