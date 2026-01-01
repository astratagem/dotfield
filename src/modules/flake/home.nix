# Standalone Home Manager configurations for faster user-level switching.
#
# This module creates `homeConfigurations` outputs that can be switched
# independently of NixOS using `nh home switch -s <specialisation>`.
{
  config,
  lib,
  inputs,
  self,
  ...
}:
let
  inherit (self.lib.modules)
    collectRequires
    resolveUserHomeModules
    resolveUserOverlays
    ;

  # Build standalone homeConfigurations for each user on each host.
  makeHomeConfigurations =
    hostName: hostSpec:
    let
      inherit (hostSpec) system;

      hostAspectDeps = collectRequires config.aspects hostSpec.aspects;
      hostAspects = hostSpec.aspects ++ hostAspectDeps;

      homeModules = [
        config.aspects.core.home
        hostSpec.baseline.home
      ];

      makeHome = username: userSpec: {
        name = "${username}@${hostName}";
        value = inputs.home-manager.lib.homeManagerConfiguration {
          pkgs = import inputs.${hostSpec.channel} {
            inherit system;
            config.allowUnfree = true;
            overlays = resolveUserOverlays { inherit username userSpec hostAspects; };
          };
          extraSpecialArgs = {
            inherit inputs self;
            flake = config;
          };
          modules = [
            inputs.stylix.homeModules.stylix
            (
              { lib, ... }:
              {
                home.username = lib.mkDefault username;
                home.homeDirectory = lib.mkDefault "/home/${username}";
              }
            )
          ] ++ resolveUserHomeModules {
            inherit username userSpec hostAspects;
            baseHomeModules = homeModules;
          };
        };
      };
    in
    lib.mapAttrsToList makeHome hostSpec.users;
in
{
  flake.homeConfigurations = builtins.listToAttrs (
    lib.flatten (lib.mapAttrsToList makeHomeConfigurations config.hosts.nixos)
  );
}
