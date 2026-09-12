# SPDX-FileCopyrightText: (C) 2026 Chris Montgomery <chmont@protonmail.com>
#
# SPDX-License-Identifier: GPL-3.0-or-later

{
  hosts.nixos.tuuvok.users.cdom.configuration = {
    services.kanshi.settings = [
      {
        output.criteria = "eDP-1";
        output.scale = 2.0;
      }
    ];
  };
}
