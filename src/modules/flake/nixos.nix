# SPDX-FileCopyrightText: (C) 2026 Chris Montgomery <chmont@protonmail.com>
#
# SPDX-License-Identifier: GPL-3.0-or-later

{
  config,
  lib,
  inputs,
  self,
  ...
}:
let
  inherit (self.lib.modules)
    collectNixosModules
    collectOverlays
    collectAspectDeps
    resolveUserHomeModules
    ;

  makeHost =
    hostName: hostSpec:
    let
      inherit (hostSpec) system;

      hostAspectDeps = collectAspectDeps config.aspects hostSpec.aspects;
      hostAspects = hostSpec.aspects ++ hostAspectDeps;

      nixosModules = (collectNixosModules hostAspects) ++ [
        inputs.home-manager.nixosModules.default
        inputs.sops-nix.nixosModules.sops
        inputs.stylix.nixosModules.stylix
        config.aspects.core.nixos
        hostSpec.configuration
      ];

      homeModules = [
        inputs.sops-nix.homeManagerModules.sops
        # FIXME: can only be included in standalone configurations --
        # causes error otherwise.
        # inputs.stylix.homeModules.stylix
        config.aspects.core.home
        hostSpec.baseline.home
      ];

      makeHome = username: hostedUserSpec: {
        imports = resolveUserHomeModules {
          inherit username hostAspects hostedUserSpec;
          baseHomeModules = homeModules;
        };
      };
    in
    inputs.${hostSpec.channel}.lib.nixosSystem {
      inherit system;
      modules = nixosModules ++ [
        {
          networking = { inherit hostName; };
          nixpkgs.config.allowUnfree = true;
          nixpkgs.overlays = (collectOverlays hostAspects) ++ [ self.overlays.default ];
          home-manager.users = lib.mapAttrs makeHome hostSpec.users;
        }
      ];
    };
in
{
  flake.nixosConfigurations = lib.mapAttrs makeHost config.hosts.nixos;
}
