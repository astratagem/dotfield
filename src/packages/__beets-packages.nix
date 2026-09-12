# SPDX-FileCopyrightText: (C) 2026 Chris Montgomery <chmont@protonmail.com>
#
# SPDX-License-Identifier: GPL-3.0-or-later

{
  perSystem =
    { inputs', pkgs, ... }:
    let
      inherit (pkgs) callPackage;
      beets = pkgs.beets-minimal;
    in
    {
      packages = rec {
        beetcamp = callPackage ./beets-packages/plugins/beetcamp.nix {
          inherit beets rich-tables;
        };
        beets-filetote = callPackage ./beets-packages/plugins/filetote.nix {
          inherit beets;
        };
        beet-summarize = callPackage ./beets-packages/plugins/summarize.nix {
          inherit beets;
        };

        rgbxy = callPackage ./python-modules/rgbxy.nix { };
        rich-tables = callPackage ./python-modules/rich-tables.nix {
          inherit rgbxy;
        };
      };
    };
}
