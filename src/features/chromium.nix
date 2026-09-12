# SPDX-FileCopyrightText: (C) 2026 Chris Montgomery <chmont@protonmail.com>
#
# SPDX-License-Identifier: GPL-3.0-or-later

{
  aspects.graphical.home =
    { pkgs, ... }:
    {
      programs.chromium = {
        enable = true;
        package = pkgs.chromium.override { enableWideVine = true; };
      };
    };
}
