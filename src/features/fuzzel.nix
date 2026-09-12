# SPDX-FileCopyrightText: (C) 2026 Chris Montgomery <chmont@protonmail.com>
#
# SPDX-License-Identifier: GPL-3.0-or-later

{
  aspects.graphical.home =
    {
      config,
      pkgs,
      lib,
      ...
    }:
    {
      programs.fuzzel.enable = true;
      programs.fuzzel.settings.main = {
        terminal = lib.mkDefault "ghostty";
      };
      home.packages = [ pkgs.fuzzel ];
    };
}
