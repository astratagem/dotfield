# SPDX-FileCopyrightText: (C) 2026 Chris Montgomery <chmont@protonmail.com>
#
# SPDX-License-Identifier: GPL-3.0-or-later

flake@{ ... }:
{
  users.cdom.aspects.noop.home =
    {
      config,
      pkgs,
      ...
    }:
    let
      nemoPackage = pkgs.nemo-with-extensions;
    in
    {
      home.packages = [ nemoPackage ];

      xdg.desktopEntries.nemo = {
        name = "Nemo";
        exec = "${nemoPackage}/bin/nemo";
      };

      xdg.mimeApps = {
        enable = true;
        defaultApplications = {
          "application/x-gnome-saved-search" = [ "nemo.desktop" ];
        };
      };

      dconf.settings."org/nemo/desktop" = {
        show-desktop-icons = false;
      };
    };
}
