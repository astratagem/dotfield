# SPDX-FileCopyrightText: (C) 2026 Chris Montgomery <chmont@protonmail.com>
#
# SPDX-License-Identifier: GPL-3.0-or-later

{
  users.cdom.aspects.music-production.home =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        ardour
        # XXX: failing build as of 2025-09-13
        # carla
        dexed
        # XXX: broken as of 2025-04-18
        # mixxx
        puredata
        qsynth
        renoise
        samplv1
        vcv-rack
      ];
    };
}
