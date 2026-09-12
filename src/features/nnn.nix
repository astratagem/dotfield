# SPDX-FileCopyrightText: (C) 2026 Chris Montgomery <chmont@protonmail.com>
#
# SPDX-License-Identifier: GPL-3.0-or-later

{
  aspects.core.home = {
    programs.nnn.enable = true;
  };

  aspects.graphical.home =
    { pkgs, ... }:
    {
      programs.nnn.extraPackages = [
        pkgs.fontpreview
        pkgs.poppler
        pkgs.viu
        pkgs.w3m # text-mode web browser
      ];
    };
}
