flake@{ ... }:
{
  users.cdom.aspects.core.home =
    { config, ... }:
    let
      inherit (config.home) homeDirectory;

      sshDir = "${homeDirectory}/.ssh";
    in
    {
      programs.ssh = {
        enable = true;
        enableDefaultConfig = false;
        includes = [ "${sshDir}/config.local" ];
        settings = {
          "atlantis" = {
            hostname = "atlantis.whatbox.ca";
            user = "syadasti";
          };

          "eu.nixbuild.net" = {
            identityFile = "${sshDir}/id_ed25519_seadome_nixbuild_net";
          };
        };
      };
    };
}
