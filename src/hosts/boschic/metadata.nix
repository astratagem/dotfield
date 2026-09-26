# SPDX-FileCopyrightText: (C) 2026 Chris Montgomery <chmont@protonmail.com>
#
# SPDX-License-Identifier: GPL-3.0-or-later

{ config, ... }:
let
  inherit (config.meta) keys;
in
{
  meta.hosts.boschic = {
    admins = [ "cdom" ];
    ipv4.address = "192.168.1.214";
    supportedFeatures = [
      "nixos-test"
      "benchmark"
      "big-parallel"
      "kvm"
    ];
    keys = {
      age = keys.age.boschic;
      ssh = [
        keys.ssh.boschic
        keys.ssh.boschic-rsa
      ];
    };
    network = "home";
    networks.ts = "100.112.94.38";
    users.cdom.keys = {
      age = keys.age.cdom-at-boschic;
      ssh = [ keys.ssh.cdom-at-boschic ];
    };
    syncthing.id = "FHFRNSL-H3GF7WZ-KNJMZFG-MUPOIAK-5HMAXDU-A6PQLPH-DKDKXUG-VZGGIAG";
  };
}
