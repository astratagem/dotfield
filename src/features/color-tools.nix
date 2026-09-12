# SPDX-FileCopyrightText: (C) 2026 Chris Montgomery <chmont@protonmail.com>
#
# SPDX-License-Identifier: GPL-3.0-or-later

{
  aspects.graphical.home =
    { pkgs, ... }:
    {
      home.packages = [
        pkgs.colorpanes # <- print panes in the 8 bright terminal colors with shadows of the respective darker color
        pkgs.pastel # <- generate, analyze, convert and manipulate colors
      ];
    };
}
