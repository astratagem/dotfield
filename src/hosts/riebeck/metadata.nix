# SPDX-FileCopyrightText: (C) 2026 Chris Montgomery <chmont@protonmail.com>
#
# SPDX-License-Identifier: GPL-3.0-or-later

{ config, ... }:
let
  inherit (config.meta) hosts keys;
in
{
  meta.hosts.riebeck = {
    hardware = {
      mem = 32;
      vcpus = 14;
      system = "x86_64-linux";

    };
    supportedFeatures = [
      "nixos-test"
      "benchmark"
      "big-parallel"
      "kvm"
    ];
    keys = {
      age = keys.age.riebeck;
      ssh = [
        keys.ssh.riebeck
        keys.ssh.riebeck-rsa
      ];
    };
    users.cdom.keys = {
      age = keys.age.cdom-at-riebeck;
      ssh = [ keys.ssh.cdom-at-riebeck ];
    };
  };
}
