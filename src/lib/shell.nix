# SPDX-FileCopyrightText: (C) 2026 Chris Montgomery <chmont@protonmail.com>
#
# SPDX-License-Identifier: GPL-3.0-or-later

{ lib, ... }:
let
  cmd =
    pkg: args:
    lib.concatStringsSep " " [
      (lib.getExe pkg)
      (toString (lib.cli.toCommandLineGNU { } args))
    ];
in
{
  flake.lib.shell = {
    inherit cmd;
  };
}
