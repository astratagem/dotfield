# SPDX-FileCopyrightText: (C) 2026 Chris Montgomery <chmont@protonmail.com>
#
# SPDX-License-Identifier: GPL-3.0-or-later

{
  aspects.workstation.home =
    { pkgs, ... }:
    {
      home.packages = [
        pkgs.darktable
        # FIXME: 2026-07-20 failing build
        # pkgs.dia
        pkgs.digikam
        pkgs.gimp-with-plugins
        pkgs.gthumb
        pkgs.hugin # image stitching (gui)
        pkgs.inkscape
        pkgs.scribus
        pkgs.shotwell
      ];
    };
}
