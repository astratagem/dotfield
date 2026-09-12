# SPDX-FileCopyrightText: (C) 2026 Chris Montgomery <chmont@protonmail.com>
#
# SPDX-License-Identifier: GPL-3.0-or-later

{ lib, moduleWithSystem, ... }:
{
  users.cdom.aspects.development.home = moduleWithSystem (
    perSystem@{ inputs' }:
    home@{ pkgs, ... }:
    let
      sessionVariables = {
        EDITOR = lib.getExe perSystem.inputs'.ceamx.packages.editor;
      };
    in
    {
      programs.emacs.ceamx.enable = true;

      home = { inherit sessionVariables; };
      programs.bash = { inherit sessionVariables; };
      programs.nushell.settings.buffer_editor = [ "emacsclient -tc" ];
    }
  );
}
