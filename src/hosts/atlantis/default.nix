{ config, ... }:
let
  inherit (config.meta) keys;
in
{
  meta.hosts.atlantis = {
    host = "atlantis.whatbox.ca";
    users.syadasti.keys = {
      age = keys.age.syadasti-at-atlantis;
      ssh = [ keys.ssh.syadasti-at-atlantis ];
    };
  };
}
