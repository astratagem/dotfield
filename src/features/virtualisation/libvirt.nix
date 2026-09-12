# SPDX-FileCopyrightText: (C) 2026 Chris Montgomery <chmont@protonmail.com>
#
# SPDX-License-Identifier: GPL-3.0-or-later

{
  aspects.libvirt.nixos =
    { config, ... }:
    {
      virtualisation.libvirtd.enable = true;
      networking.firewall.checkReversePath = "loose";
      users.groups.libvirtd = { inherit (config.users.groups.wheel) members; };
      users.groups.qemu-libvirtd = { inherit (config.users.groups.wheel) members; };
    };
}
