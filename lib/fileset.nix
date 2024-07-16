{ lib }:
let
  inherit (lib)
    filterAttrs
    elem
    unique
    concatMap
    mapAttrsToList
    substring
    hasSuffix
    ;
  inherit (lib.lists) filter;
  inherit (lib.filesystem) listFilesRecursive pathIsRegularFile pathIsDirectory;

  # import all nix files and directories
  importFilesAndDirs = dir: filter (f: f != "default.nix") (listFilesRecursive dir);

  # adapted from @nypkgs https://github.com/yunfachi/nypkgs/blob/45fb532e8911d64fb92a38e66d9643975d7187c6/lib/umport.nix
  umport =
    {
      path ? null,
      exclude ? [ ],
    }:
    let
      excludedFiles = filter (path: pathIsRegularFile path) exclude;
      excludedDirs = filter (path: pathIsDirectory path) exclude;
      isExcluded =
        path:
        if elem path excludedFiles then
          true
        else
          (filter (excludedDir: lib.path.hasPrefix excludedDir path) excludedDirs) != [ ];
    in
    unique (
      filter
        (file: pathIsRegularFile file && hasSuffix ".nix" (builtins.toString file) && !isExcluded file)
        (
          concatMap (
            _path:
            mapAttrsToList
              (name: type: _path + (if type == "directory" then "/${name}/default.nix" else "/${name}"))
              (
                filterAttrs (file: _: ((substring 0 1 file) != ".") && (file != "default.nix")) (
                  builtins.readDir _path
                )
              )
          ) (unique (if path == null then [ ] else [ path ]))
        )
    );
in
{
  inherit umport importFilesAndDirs;
}
