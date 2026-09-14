# SPDX-FileCopyrightText: (C) 2026 Chris Montgomery <chmont@protonmail.com>
#
# SPDX-License-Identifier: GPL-3.0-or-later

# The `fileSystems` a host's disko layout would produce.
#
# Evaluated in a throwaway system rather than layered onto the real host:
# merging both would collide on every fileSystems.<mp>.device.
{
  root,
  host,
  system ? "x86_64-linux",
}:
let
  flake = builtins.getFlake root;
  sys = flake.inputs.nixos-unstable.lib.nixosSystem {
    inherit system;
    modules = [
      flake.inputs.disko.nixosModules.disko
      flake.diskoConfigurations.${host}
      {
        boot.loader.grub.devices = [ "nodev" ];
        system.stateVersion = "26.05";
      }
    ];
  };
in
import ./__pick-filesystems.nix sys.config.fileSystems
