# SPDX-FileCopyrightText: (C) 2026 Chris Montgomery <chmont@protonmail.com>
#
# SPDX-License-Identifier: GPL-3.0-or-later

{
  aspects.workstation.nixos = {
    networking.firewall =
      let
        ports = {
          from = 1714;
          to = 1764;
        };
      in
      {
        allowedTCPPortRanges = [ ports ];
        allowedUDPPortRanges = [ ports ];
      };
  };

  aspects.workstation.home = {
    services.kdeconnect.enable = true;
    services.kdeconnect.indicator = true;
  };
}
