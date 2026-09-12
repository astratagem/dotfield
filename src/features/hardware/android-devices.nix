# SPDX-FileCopyrightText: (C) 2026 Chris Montgomery <chmont@protonmail.com>
#
# SPDX-License-Identifier: GPL-3.0-or-later

{
  aspects.workstation.nixos =
    { config, pkgs, ... }:
    {
      environment.systemPackages = [
        pkgs.android-file-transfer
      ];

      users.groups.adbusers = { inherit (config.users.groups.wheel) members; };
    };
}
