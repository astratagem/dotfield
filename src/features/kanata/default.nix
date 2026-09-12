# SPDX-FileCopyrightText: (C) 2026 Chris Montgomery <chmont@protonmail.com>
#
# SPDX-License-Identifier: GPL-3.0-or-later

{ self, ... }:
{
  aspects.kanata.home = {
    imports = [ self.modules.homeManager.kanata ];

    services.kanata.enable = true;
  };
}
