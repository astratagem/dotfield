# SPDX-FileCopyrightText: (C) 2026 Chris Montgomery <chmont@protonmail.com>
#
# SPDX-License-Identifier: GPL-3.0-or-later

{
  aspects.core.home =
    { config, ... }:
    {
      programs.zoxide.enable = true;
      home.sessionVariables."_ZO_DATA_DIR" = config.xdg.dataHome;
    };
}
