# SPDX-FileCopyrightText: (C) 2026 Chris Montgomery <chmont@protonmail.com>
#
# SPDX-License-Identifier: GPL-3.0-or-later

{ lib, ... }:
let
  inherit (lib) mkOption types;

  displaySubmodule = {
    options = {
      dpi = mkOption {
        type = with types; int;
        description = "Pixel density of the display device.";
      };
    };
  };
in
{
  options.meta.displays = mkOption {
    type = types.attrsOf (types.submodule displaySubmodule);
    default = { };
    description = "Displays metadata";
  };
}
