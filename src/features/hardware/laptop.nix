# SPDX-FileCopyrightText: (C) 2026 Chris Montgomery <chmont@protonmail.com>
#
# SPDX-License-Identifier: GPL-3.0-or-later

{ lib, ... }:
{
  aspects.laptop = {
    requires = [ "battery" ];
    nixos = {
      # NOTE: Requires that the $laptop variable is set!  This should be
      # added in a laptop-specific module!
      environment.etc."sway/config".text = lib.mkAfter ''
        # Clamshell mode
        # <https://github.com/swaywm/sway/wiki#user-content-clamshell-mode>
        bindswitch --reload --locked lid:on output $laptop disable
        bindswitch --reload --locked lid:off output $laptop enable
      '';
    };
  };
}
