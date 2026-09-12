# SPDX-FileCopyrightText: (C) 2026 Chris Montgomery <chmont@protonmail.com>
#
# SPDX-License-Identifier: GPL-3.0-or-later

{
  aspects.lix.nixos =
    { pkgs, ... }:
    {
      # FIXME: suggested by manual, but results in infinite recursion
      # nixpkgs.overlays = [
      #   (final: prev: {
      #     inherit (prev.lixPackageSets.stable)
      #       nixpkgs-review
      #       nix-eval-jobs
      #       nix-fast-build
      #       colmena
      #       ;
      #   })
      # ];

      nix.package = pkgs.lixPackageSets.stable.lix;
    };
}
