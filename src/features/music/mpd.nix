# SPDX-FileCopyrightText: (C) 2026 Chris Montgomery <chmont@protonmail.com>
#
# SPDX-License-Identifier: GPL-3.0-or-later

{
  aspects.graphical.home = {
    services.mpd = {
      enable = true;
      network.startWhenNeeded = true;
      network.listenAddress = "127.0.0.1";
      network.port = 6600;
    };

    programs.ncmpcpp.enable = true;
    services.amberol.enable = true;
  };
}
