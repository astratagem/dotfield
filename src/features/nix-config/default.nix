# Copyright (C) 2022-2025 Chris Montgomery
# SPDX-License-Identifier: GPL-2.0-or-later

flake@{ inputs, ... }:

{
  aspects.core.nixos =
    {
      config,
      pkgs,
      ...
    }:
    let
      cfg = config.nix;
    in
    {
      imports = [
        ./__store.nix
        ./__substituters.nix
      ];

      environment.systemPackages = [ cfg.package ];

      nix = {
        nixPath = [
          "nixpkgs=${pkgs.path}"
          "home-manager=${inputs.home-manager}"
        ];
        distributedBuilds = true;
        settings = {
          allowed-users = [ "*" ];
          trusted-users = [
            "root"
            "@wheel"
          ];

          experimental-features = [
            "flakes"
            "nix-command"
            (if cfg.package.pname == "lix" then "pipe-operator" else "pipe-operators")
          ];

          system-features = flake.config.meta.hosts.${config.networking.hostName}.supportedFeatures;
        };
      };
    };
}
