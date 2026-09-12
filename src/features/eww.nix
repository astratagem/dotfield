# SPDX-FileCopyrightText: (C) 2026 Chris Montgomery <chmont@protonmail.com>
#
# SPDX-License-Identifier: GPL-3.0-or-later

{
  aspects.graphical.home =
    { config, ... }:
    let
      cfg = config.programs.eww;
    in
    {
      programs.eww.enable = true;
      home.packages = [ cfg.package ];
    };
}
