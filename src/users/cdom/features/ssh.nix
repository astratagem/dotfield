# SPDX-FileCopyrightText: (C) 2026 Chris Montgomery <chmont@protonmail.com>
#
# SPDX-License-Identifier: GPL-3.0-or-later

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
