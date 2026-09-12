# SPDX-FileCopyrightText: (C) 2026 Chris Montgomery <chmont@protonmail.com>
#
# SPDX-License-Identifier: GPL-3.0-or-later

{ config, lib, ... }:
let
  inherit (config) meta;
in
{
  users.cdom.aspects.core.home =
    { pkgs, ... }:
    {
      home.packages = [ pkgs.rclone ];
      home.sessionVariables.NNN_RCLONE = "rclone mount --fast-list";
      programs.rclone.enable = true;
    };

  users.cdom.aspects.workstation.home =
    { config, ... }:
    let
      mountDir = "${config.home.homeDirectory}/mnt";
    in
    {
      programs.rclone = {
        requiresUnit = "sops-nix.service";
        remotes = {
          "synoxyn" = {
            config = {
              type = "sftp";
              host = meta.hosts.synoxyn.ipv4.address;
              key_file = "~/.ssh/id_ed25519";
              shell_type = "unix";
              md5sum_command = "none";
              sha1sum_command = "none";
            };
            mounts."".mountPoint = "${mountDir}/synoxyn";
          };
        };
      };
    };
}
