# SPDX-FileCopyrightText: (C) 2026 Chris Montgomery <chmont@protonmail.com>
#
# SPDX-License-Identifier: GPL-3.0-or-later

{ self, lib, ... }:
let
  inherit (lib) mkOption types;
  inherit (self.lib.modules) aspectSubmoduleGenericOptions mkAspectNameOpt;
  aspectSubmodule =
    { name, ... }:
    {
      options = aspectSubmoduleGenericOptions // {
        name = mkAspectNameOpt name;
      };
    };
in
{
  options.aspects = mkOption {
    type = types.lazyAttrsOf (types.submodule aspectSubmodule);
    default = { };
  };
}
