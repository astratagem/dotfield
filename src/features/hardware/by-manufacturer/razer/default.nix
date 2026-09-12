# SPDX-FileCopyrightText: (C) 2026 Chris Montgomery <chmont@protonmail.com>
#
# SPDX-License-Identifier: GPL-3.0-or-later

{
  aspects.hardware__razer.nixos =
    { config, pkgs, ... }:
    {
      environment.systemPackages = [
        pkgs.razergenie # Razer device configuration GUI (Qt)
        # pkgs.polychromatic # Lighting management GUI for Razer devices
      ];

      hardware.openrazer = {
        enable = true;
        keyStatistics = false;
        # Notifications are super frequent, repetitive, and sometimes just report 0%.
        # The upstream issue tracker has quite a few related issues:
        # <https://github.com/openrazer/openrazer/issues?q=notification+battery>
        batteryNotifier.enable = false;
      };

      users.groups.openrazer = { inherit (config.users.groups.wheel) members; };
    };
}
