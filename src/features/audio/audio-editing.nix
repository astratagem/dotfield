# SPDX-FileCopyrightText: (C) 2026 Chris Montgomery <chmont@protonmail.com>
#
# SPDX-License-Identifier: GPL-3.0-or-later

{
  aspects.workstation.home =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        audacity
        sox
        # XXX(2025-11-14): build failure
        # tenacity
      ];
    };
}
