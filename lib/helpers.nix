_: let
  # return an int based on boolean value
  boolToNum = bool:
    if bool
    then 1
    else 0;

  # a function that checks if a list contains a list of given strings
  containsStrings = {
    list,
    targetStrings,
  }:
    builtins.all (s: builtins.any (x: x == s) list) targetStrings;

  # create a git url alias
  giturl = {
    domain,
    alias,
    user ? "git",
    ...
  }: {
    "https://${domain}/".insteadOf = "${alias}:";
    "ssh://${user}@${domain}/".pushInsteadOf = "${alias}:";
  };
in {
  inherit boolToNum containsStrings giturl;
}
