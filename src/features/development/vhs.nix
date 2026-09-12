# SPDX-FileCopyrightText: (C) 2026 Chris Montgomery <chmont@protonmail.com>
#
# SPDX-License-Identifier: GPL-3.0-or-later

{
  aspects.development.home =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        vhs
      ];
    };
}
