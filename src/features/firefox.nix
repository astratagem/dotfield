{
  aspects.graphical.nixos =
    { pkgs, ... }:
    {
      programs.firefox = {
        enable = true;
        nativeMessagingHosts.packages = [
          pkgs.tridactyl-native
          pkgs.passff-host
        ];
      };
    };

  aspects.graphical.home =
    hmArgs@{
      lib,
      config,
      pkgs,
      ...
    }:
    {
      programs.firefox = {
        enable = true;
        package =
          if (hmArgs.osConfig.programs.firefox.enable or false) then
            (hmArgs.osConfig.programs.firefox.package or pkgs.firefox)
          else
            pkgs.firefox;
        configPath = "${config.xdg.configHome}/mozilla/firefox";
      };

      # TODO: Disabled by default due to the limitation of needing to
      # specify each profile name to be handled by Stylix, which cannot
      # be determined here without configurating a common base profile
      # for each user.
      stylix.targets.firefox.enable = lib.mkDefault false;
    };

  aspects.desktop-sessions__gnome.home = {
    dconf.settings."org/gnome/desktop/notifications/application/firefox" = {
      application-id = "firefox.desktop";
    };
  };
}
