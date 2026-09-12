# SPDX-FileCopyrightText: (C) 2026 Chris Montgomery <chmont@protonmail.com>
#
# SPDX-License-Identifier: GPL-3.0-or-later

{
  aspects.graphical.home =
    { pkgs, ... }:
    {
      programs.mpv = {
        enable = true;
        scripts = with pkgs.mpvScripts; [
          thumbnail
          mpv-playlistmanager
        ];
        config = {
          cache-default = 4000000;
          gpu-context = "wayland";
        };
      };
    };
}
