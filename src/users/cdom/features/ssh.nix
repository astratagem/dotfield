flake@{ ... }:
{
  users.cdom.aspects.core.home =
    { config, ... }:
    let
      inherit (config.home) homeDirectory;
      inherit (flake.config.meta) hosts;

      sshDir = "${homeDirectory}/.ssh";
      identityFile = "${sshDir}/id_ed25519";
    in
    {

      programs.ssh = {
        enable = true;
        enableDefaultConfig = false;
        includes = [ "~/.config/ssh/config.local" ];
        settings = {
          "synoxyn" = {
            hostname = hosts.synoxyn.ipv4.address;
            port = 2367;
          };

          "atlantis" = {
            hostname = "atlantis.whatbox.ca";
            user = "syadasti";
          };

          "eu.nixbuild.net" = {
            identityFile = "${sshDir}/id_ed25519_seadome_nixbuild_net";
          };

          "*" = {
            inherit identityFile;

            AddKeysToAgent = "no";
            Compression = false;
            ControlMaster = "auto";
            ControlPath = "~/.ssh/master-%r@%n:%p";
            ControlPersist = "10m";
            ForwardAgent = false;
            HashKnownHosts = false;
            IdentitiesOnly = true;
            ServerAliveCountMax = 3;
            ServerAliveInterval = 300;
            UserKnownHostsFile = "~/.ssh/known_hosts";
          };
        };
      };
    };
}
