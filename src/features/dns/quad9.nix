# SPDX-FileCopyrightText: (C) 2026 Chris Montgomery <chmont@protonmail.com>
#
# SPDX-License-Identifier: GPL-3.0-or-later

{ inputs, ... }:
let
  inherit (inputs.apparat.lib.net.constants) dns;
in
{
  aspects.dns__quad9.nixos = {
    networking.nameservers = dns.nameservers.quad9;
    networking.networkmanager.insertNameservers = dns.nameservers.quad9;
  };
}
