# SPDX-FileCopyrightText: (C) 2026 Chris Montgomery <chmont@protonmail.com>
#
# SPDX-License-Identifier: GPL-3.0-or-later

{
  aspects.secret-service__gnome-keyring.nixos =
    { pkgs, ... }:
    {
      services.gnome.gnome-keyring.enable = true;
      environment.systemPackages = [ pkgs.seahorse ];
      # TODO: probably not necessary
      # xdg.portal.config.common."org.freedesktop.impl.portal.Secret" = [ "gnome-keyring" ];
    };
}
