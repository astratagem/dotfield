# SPDX-FileCopyrightText: (C) 2026 Chris Montgomery <chmont@protonmail.com>
#
# SPDX-License-Identifier: GPL-3.0-or-later

{
  users.cdom.aspects.graphical.home = {
    dconf.settings = {
      "org/gnome/desktop/input-sources".xkb-options = [ "caps:ctrl_modifier" ];
      "org/gnome/desktop/interface".gtk-key-theme = "Emacs";
    };
  };
}
