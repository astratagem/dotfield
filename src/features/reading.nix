# SPDX-FileCopyrightText: (C) 2026 Chris Montgomery <chmont@protonmail.com>
# SPDX-License-Identifier: GPL-3.0-or-later
{
  aspects.workstation.nixos = { config, ... }: {
    services.calibre-server.port = 9090;
    networking.firewall.allowedTCPPorts = [ config.services.calibre-server.port ];
  };

  aspects.workstation.home =
    { pkgs, ... }:
    {
      home.packages = [
        pkgs.calibre
        # XXX(2025-11-14): build failure
        # pkgs.mcomix
      ];
    };
}
