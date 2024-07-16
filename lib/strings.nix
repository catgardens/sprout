{ lib }:
let
  # a function that checks if a list contains a list of given strings
  containsStrings =
    list: targetStrings: builtins.all (s: builtins.any (x: x == s) list) targetStrings;

  inherit (lib.strings) toUpper;
  inherit (builtins) substring stringLength;

  # a function that makes the first letter of a string uppercase
  mkUpper = str: (toUpper (substring 0 1 str)) + (substring 1 (stringLength str) str);
in
{
  inherit mkUpper containsStrings;
}
