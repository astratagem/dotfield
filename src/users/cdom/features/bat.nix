# SPDX-FileCopyrightText: (C) 2026 Chris Montgomery <chmont@protonmail.com>
#
# SPDX-License-Identifier: GPL-3.0-or-later

{
  users.cdom.aspects.core.home =
    { pkgs, ... }:
    {
      home.shellAliases."grr" = "${pkgs.bat-extras.batgrep}/bin/batgrep";
      home.shellAliases."man" = "${pkgs.bat-extras.batman}/bin/batman";
    };
}
