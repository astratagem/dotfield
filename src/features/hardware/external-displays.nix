# SPDX-FileCopyrightText: (C) 2026 Chris Montgomery <chmont@protonmail.com>
#
# SPDX-License-Identifier: GPL-3.0-or-later

{
  aspects.graphical.nixos = { config, pkgs, ... }: {
    services.ddccontrol.enable = true;
    hardware.i2c.enable = true;
    environment.systemPackages = [
      pkgs.ddcutil
    ];

    users.groups.i2c = { inherit (config.users.groups.wheel) members; };
  };
}
