# SPDX-FileCopyrightText: (C) 2026 Chris Montgomery <chmont@protonmail.com>
#
# SPDX-License-Identifier: GPL-3.0-or-later

{
  aspects.workstation.home = { lib, pkgs, ... }: {
    home.packages = [
      pkgs.zotero
      pkgs.zotero-translation-server
    ];

    # Make the bundled integration extensions available at a stable path for
    # integration targets.
    #
    # For more background on this issue, see:
    # <https://wiki.nixos.org/wiki/Zotero>
    xdg.dataFile."zotero/lib/integration".source = "${pkgs.zotero}/lib/integration";
  };
}
