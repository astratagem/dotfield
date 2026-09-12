# SPDX-FileCopyrightText: (C) 2026 Chris Montgomery <chmont@protonmail.com>
#
# SPDX-License-Identifier: GPL-3.0-or-later

{ lib, ... }:
let
  inherit (lib) mkOption types;
in
{
  options.flake.lib = mkOption {
    description = "Internal helpers library";
    type = with types; lazyAttrsOf raw;
    default = { };
  };
}
