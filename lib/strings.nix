let
  # a function that checks if a list contains a list of given strings
  containsStrings =
    list: targetStrings: builtins.all (s: builtins.any (x: x == s) list) targetStrings;
in
{
  inherit containsStrings;
}
