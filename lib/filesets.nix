{ lib }:
let
  inherit (lib.lists) filter;
  inherit (lib.filesystem) listFilesRecursive;

  # import all nix files and directories
  importFilesAndDirs = dir: filter (f: f != "default.nix") (listFilesRecursive dir);
in
{
  inherit importFilesAndDirs;
}
