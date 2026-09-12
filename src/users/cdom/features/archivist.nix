# SPDX-FileCopyrightText: (C) 2026 Chris Montgomery <chmont@protonmail.com>
#
# SPDX-License-Identifier: GPL-3.0-or-later

{ config, moduleWithSystem, ... }:
let
  inherit (config.meta) hosts;
in
{
  aspects.workstation.home = moduleWithSystem (
    perSystem@{ config }:
    { config, pkgs, ... }:
    let
      mountDir = "${config.home.homeDirectory}/mnt";
    in
    {
      home.packages = [
        perSystem.config.packages.aax-to-m4b
        pkgs.aaxtomp3
        pkgs.audible-cli
      ];

      programs.rclone.remotes."whatbox" = {
        config = {
          type = "sftp";
          host = hosts.atlantis.host;
          user = "syadasti";
          key_file = "~/.ssh/id_ed25519";
          shell_type = "unix";
          md5sum_command = "md5sum";
          sha1sum_command = "sha1sum";
        };
        mounts."".mountPoint = "${mountDir}/whatbox";
      };
    }
  );
}
