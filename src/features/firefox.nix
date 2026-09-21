# SPDX-FileCopyrightText: (C) 2026 Chris Montgomery <chmont@protonmail.com>
# SPDX-License-Identifier: GPL-3.0-or-later
{
  aspects.graphical.nixos =
    { pkgs, ... }:
    {
      environment.systemPackages = [ pkgs.firefox ];
    };

  aspects.graphical.home =
    {
      lib,
      config,
      pkgs,
      ...
    }:
    {
      programs.firefox = {
        enable = true;
        nativeMessagingHosts = [
          pkgs.tridactyl-native
          pkgs.passff-host
        ];
        configPath = "${config.xdg.configHome}/mozilla/firefox";
      };

      # TODO: Disabled by default due to the limitation of needing to
      # specify each profile name to be handled by Stylix, which cannot
      # be determined here without configurating a common base profile
      # for each user.
      stylix.targets.firefox.enable = lib.mkDefault false;
    };

  aspects.desktop-sessions__gnome.home = {
    programs.firefox.enableGnomeExtensions = true;
    dconf.settings."org/gnome/desktop/notifications/application/firefox" = {
      application-id = "firefox.desktop";
    };
  };
}
