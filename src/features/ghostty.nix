# SPDX-FileCopyrightText: (C) 2026 Chris Montgomery <chmont@protonmail.com>
#
# SPDX-License-Identifier: GPL-3.0-or-later

{
  aspects.graphical.home = {
    programs.ghostty = {
      enable = true;
      enableBashIntegration = true;
      enableFishIntegration = true;
      installBatSyntax = true;
      settings = {
        keybind = [ ];
        # https://gist.github.com/jake-stewart/0a8ea46159a7da2c808e5be2177e1783
        palette-generate = true;
      };
    };
    dconf.settings."org/cinnamon/desktop/applications/terminal".exec = "ghostty";
  };
}
