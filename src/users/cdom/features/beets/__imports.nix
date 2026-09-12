# SPDX-FileCopyrightText: (C) 2026 Chris Montgomery <chmont@protonmail.com>
#
# SPDX-License-Identifier: GPL-3.0-or-later

{ config, ... }:
let
  cfg = config.programs.beets;
in
{
  programs.beets.settings = {
    import = {
      bell = true;
      copy = false;
      duplicate_action = "ask";
      incremental = true;
      languages = "en";
      move = true;
      resume = true;
      write = true;
    };

    importfeeds = {
      absolutepath = false;
      dir = "${config.xdg.userDirs.music}/imports";
      formats = "m3u m3u_session";
      relative_to = cfg.settings.directory;
    };
  };
}
