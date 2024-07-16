_: let
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
  inherit giturl;
}
