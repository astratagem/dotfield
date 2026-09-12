# SPDX-FileCopyrightText: (C) 2026 Chris Montgomery <chmont@protonmail.com>
#
# SPDX-License-Identifier: GPL-3.0-or-later

{ self, ... }:
{
  users.cdom.aspects.core.home =
    { pkgs, ... }:
    let
      shellAbbrs = import ../__abbrs.nix { inherit pkgs; };
    in
    {
      programs.fish = {
        inherit shellAbbrs;
        plugins =
          [
            pkgs.fishPlugins.autopair
            pkgs.fishPlugins.done
          ]
          |> builtins.map self.lib.fish.toPluginAttrs;
        interactiveShellInit = builtins.readFile ./interactive.fish;
      };
    };
}
