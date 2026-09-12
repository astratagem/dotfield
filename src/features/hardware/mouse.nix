# SPDX-FileCopyrightText: (C) 2026 Chris Montgomery <chmont@protonmail.com>
#
# SPDX-License-Identifier: GPL-3.0-or-later

{ lib, ... }:
{
  aspects.graphical.home = {
    dconf.settings."org/gnome/desktop/peripherals/mouse" = {
      accel-profile = lib.mkDefault "adaptive";
    };
  };
}
