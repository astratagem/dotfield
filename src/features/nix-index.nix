# SPDX-FileCopyrightText: (C) 2026 Chris Montgomery <chmont@protonmail.com>
#
# SPDX-License-Identifier: GPL-3.0-or-later

# nix-index :: Nix-oriented package search tool and `command-not-found` replacement
#
# ::: {.note}
# `nix-index` is useful in itself, but fish shell *needs* it, as
# `command-not-found` simply spits out errors.
# :::
#
# <https://github.com/nix-community/nix-index>

{ inputs, ... }:
{
  aspects.core.home = {
    imports = [
      inputs.nix-index-database.homeModules.nix-index
    ];

    programs.command-not-found.enable = false;
    programs.nix-index.enable = true;
    programs.nix-index.symlinkToCacheHome = true;
    programs.nix-index-database.comma.enable = true;
  };
}
