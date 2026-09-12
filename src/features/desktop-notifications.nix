# SPDX-FileCopyrightText: (C) 2026 Chris Montgomery <chmont@protonmail.com>
#
# SPDX-License-Identifier: GPL-3.0-or-later

{ moduleWithSystem, ... }:
{
  aspects.desktop-sessions__wayland-wm.home = moduleWithSystem (
    perSystem@{ config }:
    {
      services.dunst.enable = true;
      home.packages = [ perSystem.config.packages.dunst-meter-notify ];
    }
  );
}
