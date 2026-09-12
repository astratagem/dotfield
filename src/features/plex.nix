# SPDX-FileCopyrightText: (C) 2026 Chris Montgomery <chmont@protonmail.com>
#
# SPDX-License-Identifier: GPL-3.0-or-later

{ lib, ... }:
{
  aspects.workstation.home =
    { pkgs, ... }:
    {
      home.packages =
        # XXX: Unsupported platform.
        lib.optionals (pkgs.stdenv.hostPlatform.system != "aarch64-linux") [ pkgs.plex-desktop ];
    };
}
