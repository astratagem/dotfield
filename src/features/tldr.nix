# SPDX-FileCopyrightText: (C) 2026 Chris Montgomery <chmont@protonmail.com>
#
# SPDX-License-Identifier: GPL-3.0-or-later

{ lib, ... }:
{
  aspects.core.home =
    { config, ... }:
    let
      inherit (config) xdg;
    in
    {
      programs.tealdeer.enable = true;
      programs.tealdeer.settings = {
        display = {
          use_pager = false;
          compact = false;
        };
        updates = {
          auto_update = true;
          auto_update_interval_hours = 24 * 7;
        };
        directories.cache_dir = "${xdg.cacheHome}/tealdeer";
      };

      programs.television.channels = {
        tldr = {
          metadata = {
            description = "Browse and preview TLDR help pages";
            name = "tldr";
            requirements = [ "tldr" ];
          };
          actions = {
            open = {
              command = "tldr '{}' | less";
              description = "Open TLDR page in pager";
              mode = "fork";
            };
          };
          keybindings = {
            ctrl-e = "actions:open";
          };
          preview = {
            command = "tldr '{}'";
          };
          source = {
            command = "tldr --list";
          };
          ui = {
            preview_panel = {
              size = 60;
            };
          };
        };

      };
    };
}
