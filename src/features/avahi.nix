# SPDX-FileCopyrightText: (C) 2026 Chris Montgomery <chmont@protonmail.com>
#
# SPDX-License-Identifier: GPL-3.0-or-later

{
  # Network service discovery via multicast DNS (mDNS)
  # NOTE: Enable firewall explicitly in other profiles or machine configs.
  aspects.workstation.nixos = {
    services.avahi = {
      enable = true;
      nssmdns4 = true;
    };
  };
}
