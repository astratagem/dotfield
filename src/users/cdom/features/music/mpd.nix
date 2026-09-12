# SPDX-FileCopyrightText: (C) 2026 Chris Montgomery <chmont@protonmail.com>
#
# SPDX-License-Identifier: GPL-3.0-or-later

{
  users.cdom.aspects.graphical.home =
    { pkgs, config, ... }:
    let
      beetsCfg = config.programs.beets;
    in
    {
      services.mpd = {
        enable = true;
        musicDirectory = beetsCfg.settings.directory;
        playlistDirectory = "${config.xdg.userDirs.music}/playlists";
      };

      programs.beets.mpdIntegration = {
        enableStats = true;
        enableUpdate = true;
      };

      programs.ncmpcpp.enable = true;
      services.amberol.enable = true;

      home.packages = with pkgs; [
        mpc
        cantata # qt gui (ick)
        mmtc
        pms
      ];
    };
}
