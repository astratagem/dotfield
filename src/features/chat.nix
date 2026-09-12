# SPDX-FileCopyrightText: (C) 2026 Chris Montgomery <chmont@protonmail.com>
#
# SPDX-License-Identifier: GPL-3.0-or-later

{
  aspects.workstation.home =
    { lib, pkgs, ... }:
    {
      home.packages = [
        pkgs.fluffychat
        pkgs.teams-for-linux
        pkgs.weechat
      ]
      # XXX: Unsupported platform.
      ++ lib.optionals (pkgs.stdenv.hostPlatform.system != "aarch64-linux") [
        pkgs.discord
        pkgs.slack
      ];
    };
}
