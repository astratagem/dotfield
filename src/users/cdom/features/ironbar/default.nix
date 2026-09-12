# SPDX-FileCopyrightText: (C) 2026 Chris Montgomery <chmont@protonmail.com>
#
# SPDX-License-Identifier: GPL-3.0-or-later

{ inputs, ... }:
{
  users.cdom.aspects.desktop-sessions__wayland-wm.home =
    {
      ...
    }:
    {
      imports = [
        inputs.ironbar.homeManagerModules.default
        ./__check-weather.nix
      ];

      programs.ironbar = {
        enable = true;
        systemd = true;
      };
    };
}
