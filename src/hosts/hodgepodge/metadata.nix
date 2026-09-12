# SPDX-FileCopyrightText: (C) 2026 Chris Montgomery <chmont@protonmail.com>
#
# SPDX-License-Identifier: GPL-3.0-or-later

{ config, ... }:
let
  inherit (config.meta) keys;
in
{
  meta.hosts.hodgepodge = {
    admins = [ "seadoom" ];
    ipv4.address = "192.168.1.152";
    supportedFeatures = [
      "nixos-test"
      "benchmark"
      "big-parallel"
      "kvm"
    ];
    keys = {
      age = keys.age."hodgepodge";
      ssh = [ keys.hodgepodge ];
    };
    network = "home";
    networks.ts = "100.71.240.35";
    users.seadoom.keys.ssh = [ keys.ssh.seadoom-at-hodgepodge ];
    syncthing.id = "W7EFFEO-BAZIKPC-M5C2OOT-JXR6CIP-MISL4ID-2ZUBFYT-44ZEWUK-6R75OA3";
  };
}
