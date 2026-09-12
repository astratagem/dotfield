# SPDX-FileCopyrightText: (C) 2026 Chris Montgomery <chmont@protonmail.com>
#
# SPDX-License-Identifier: GPL-3.0-or-later

{
  aspects.workstation.nixos =
    { pkgs, config, ... }:
    {
      services.printing = {
        enable = true;
        drivers = [
          pkgs.cups-browsed
          pkgs.cups-filters
          pkgs.hplip
        ];
      };

      services.avahi.openFirewall = true;

      # scanner support
      hardware.sane = {
        enable = true;
        openFirewall = true;
      };

      users.groups.cups = { inherit (config.users.groups.wheel) members; };
      users.groups.lp = { inherit (config.users.groups.wheel) members; };
      users.groups.scanner = { inherit (config.users.groups.wheel) members; };
    };
}
