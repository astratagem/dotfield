# SPDX-FileCopyrightText: (C) 2026 Chris Montgomery <chmont@protonmail.com>
#
# SPDX-License-Identifier: GPL-3.0-or-later

{
  imports = [
    ./__beets-packages.nix
    ./__by-name.nix
  ];

  perSystem =
    { pkgs, system, ... }:
    {
      packages = {
        difftastic-16k = pkgs.difftastic.overrideAttrs (oldAttrs: {
          JEMALLOC_SYS_WITH_LG_PAGE = "16";
        });
      };
    };
}
