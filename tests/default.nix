# SPDX-FileCopyrightText: (C) 2026 Chris Montgomery <chmont@protonmail.com>
#
# SPDX-License-Identifier: GPL-3.0-or-later

{ inputs, ... }:
{
  imports = [ (inputs.import-tree ./lib) ];

  # perSystem =
  #   { ... }:
  #   {
  #     nix-unit.inputs = {
  #       inherit (inputs)
  #         nixpkgs
  #         nixpkgs-lib
  #         flake-parts
  #         git-hooks
  #         globset
  #         apparat
  #         nix-unit
  #         ;
  #     };
  #   };
}
