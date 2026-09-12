# SPDX-FileCopyrightText: (C) 2026 Chris Montgomery <chmont@protonmail.com>
#
# SPDX-License-Identifier: GPL-3.0-or-later

{
  aspects.hardware__thunderbolt.nixos =
    { pkgs, ... }:
    {
      services.hardware.bolt.enable = true;

      environment.systemPackages = [
        pkgs.kdePackages.plasma-thunderbolt
      ];
    };
}
