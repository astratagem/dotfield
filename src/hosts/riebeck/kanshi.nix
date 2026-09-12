# SPDX-FileCopyrightText: (C) 2026 Chris Montgomery <chmont@protonmail.com>
#
# SPDX-License-Identifier: GPL-3.0-or-later

{
  hosts.nixos.riebeck.baseline.home = {
    services.kanshi.enable = true;
    services.kanshi.settings = [
      {
        output.criteria = "eDP-1";
        output.scale = 2.0;
      }
    ];
  };
}
