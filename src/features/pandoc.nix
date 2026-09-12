# SPDX-FileCopyrightText: (C) 2026 Chris Montgomery <chmont@protonmail.com>
#
# SPDX-License-Identifier: GPL-3.0-or-later

{
  aspects.workstation.home =
    { config, ... }:
    let
      cfg = config.programs.pandoc;
    in
    {
      programs.pandoc.enable = true;
      home.packages = [ cfg.finalPackage ];
    };
}
