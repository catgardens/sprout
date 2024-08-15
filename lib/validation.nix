{ lib, ... }:
let
  inherit (builtins) filter hasAttr;
  inherit (lib.lists) any;

  # a function that will append a list of groups if they exist in config.users.groups
  ifTheyExist = config: groups: filter (group: hasAttr group config.users.groups) groups;

  # a function that returns a boolean based on whether or not the groups exist
  ifGroupsExist = config: groups: any (group: hasAttr group config.users.groups) groups;
in
{
  inherit ifTheyExist ifGroupsExist;
}
