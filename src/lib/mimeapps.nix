# SPDX-FileCopyrightText: (C) 2026 Chris Montgomery <chmont@protonmail.com>
#
# SPDX-License-Identifier: GPL-3.0-or-later

let
  desktopEntryNames = {
    file-roller = "org.gnome.FileRoller";
    ghostty = "com.mitchellh.ghostty";
    loupe = "org.gnome.Loupe";
    nautilus = "org.gnome.Nautilus";
    zathura = "org.pwmt.zathura-pdf-mupdf";
  };

  nameFor = app: (desktopEntryNames.${app} or app) + ".desktop";
in
{
  flake.lib.mimeapps = {
    inherit desktopEntryNames nameFor;
  };
}
