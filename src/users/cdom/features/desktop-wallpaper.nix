# SPDX-FileCopyrightText: (C) 2026 Chris Montgomery <chmont@protonmail.com>
#
# SPDX-License-Identifier: GPL-3.0-or-later

{
  aspects.graphical.home =
    { config, ... }:
    {
      services.wpaperd = {
        enable = true;
        settings = {
          default.mode = "fit-border-color";
        };
      };
    };
}
