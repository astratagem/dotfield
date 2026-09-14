# SPDX-FileCopyrightText: 2026 Chris Montgomery <chmont@proton.me>
# SPDX-License-Identifier: GPL-3.0-or-later

# A bootable recovery/installation image.
#
# Deliberately *not* a `hosts.nixos.*` entry: `makeHost` assembles every host
# with home-manager, sops-nix and stylix and expects a `meta.hosts` entry, none
# of which suit an ephemeral live image with no persistent identity.

flake@{
  self,
  config,
  inputs,
  ...
}:
let
  system = "x86_64-linux";
  channel = inputs.nixos-unstable;

  installerSystem = channel.lib.nixosSystem {
    inherit system;
    modules = [
      "${channel}/nixos/modules/installer/cd-dvd/installation-cd-graphical-gnome.nix"
      inputs.disko.nixosModules.disko
      inputs.home-manager.nixosModules.default
      inputs.sops-nix.nixosModules.sops

      { nixpkgs.overlays = [ self.overlays.default ]; }

      config.aspects.core.nixos

      (import ./__configuration.nix flake)
    ];
  };
in
{
  flake.nixosConfigurations.installer = installerSystem;

  perSystem =
    { system, lib, ... }:
    lib.mkIf (system == "x86_64-linux") {
      packages.installer-iso = installerSystem.config.system.build.isoImage;
    };
}
