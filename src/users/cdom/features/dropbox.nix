# SPDX-FileCopyrightText: (C) 2026 Chris Montgomery <chmont@protonmail.com>
#
# SPDX-License-Identifier: GPL-3.0-or-later

{
  users.cdom.aspects.workstation.home =
    { config, ... }:
    let
      mountDir = "${config.home.homeDirectory}/mnt";
    in
    {
      services.dropbox.enable = true;

      sops.secrets."rclone/dropbox/token" = { };
      programs.rclone.remotes."dropbox" = {
        config.type = "dropbox";
        mounts."" = {
          # enable = true;
          mountPoint = "${mountDir}/dropbox";
        };
        secrets.token = config.sops.secrets."rclone/dropbox/token".path;
      };
    };
}
