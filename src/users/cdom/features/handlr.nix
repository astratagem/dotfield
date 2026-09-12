# SPDX-FileCopyrightText: (C) 2026 Chris Montgomery <chmont@protonmail.com>
#
# SPDX-License-Identifier: GPL-3.0-or-later

{
  users.cdom.aspects.graphical.home =
    { pkgs, ... }:
    {
      home.packages = [
        pkgs.handlr-regex
        (pkgs.writeShellScriptBin "xterm" ''
          handlr launch x-scheme-handler/terminal -- "$@"
        '')
      ];
    };
}
