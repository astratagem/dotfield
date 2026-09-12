# SPDX-FileCopyrightText: (C) 2026 Chris Montgomery <chmont@protonmail.com>
#
# SPDX-License-Identifier: GPL-3.0-or-later

{
  aspects.graphical.home =
    { lib, pkgs, ... }:
    let
      inherit (pkgs.stdenv.hostPlatform) system;
    in
    {
      home.packages = [
        pkgs.spotify-player
      ]
      # XXX: broken upstream
      ++ (lib.optional (system != "aarch64-linux") pkgs.spotify);
    };
}
