{ moduleWithSystem, ... }:
{
  users.cdom.aspects.graphical.home = moduleWithSystem (
    perSystem@{ config }:
    {
      config,
      lib,
      pkgs,
      ...
    }:
    let
      wallpaperDir = "${config.home.homeDirectory}/Pictures/wallpapers/src";

      toColorSchemePath = scheme: "${pkgs.base16-schemes}/share/themes/${scheme}.yaml";

      schemes = {
        dark = "catppuccin-mocha";
        light = "catppuccin-latte";
      };

      cursors = {
        dark = "phinger-cursors-dark";
        light = "phinger-cursors-light";
      };

      wallpaperDark = "rougier--recursive-voronoi--inverted.png";
      wallpaperLight = "rougier--recursive-voronoi.png";
    in
    {
      stylix.enable = true;

      # Default to dark theme (base configuration before specialisation)
      stylix.base16Scheme = toColorSchemePath schemes.dark;

      services.wpaperd.settings.any.path = "${wallpaperDir}/dark/${wallpaperDark}";

      specialisation = {
        dark.configuration = {
          services.wpaperd.settings.any.path = lib.mkForce "${wallpaperDir}/dark/${wallpaperDark}";
          stylix.base16Scheme = lib.mkForce (toColorSchemePath schemes.dark);
          stylix.cursor.name = lib.mkForce cursors.dark;
        };
        light.configuration = {
          services.wpaperd.settings.any.path = lib.mkForce "${wallpaperDir}/light/${wallpaperLight}";
          stylix.base16Scheme = lib.mkForce (toColorSchemePath schemes.light);
          stylix.cursor.name = lib.mkForce cursors.light;
        };
      };

      stylix.fonts = {
        sizes = {
          applications = 10;
          desktop = 10;
          popups = 8;
          terminal = 10;
        };

        sansSerif = {
          name = "Inter";
          package = pkgs.inter;
          # name = "Berkeley Mono";
          # package = perSystem.config.packages.berkeley-mono;
        };

        serif = {
          name = "Aporetic Serif";
          package = pkgs.aporetic;
        };

        monospace = {
          name = "Aporetic Sans Mono";
          package = pkgs.aporetic;
        };
      };

      # alternatively: posy-cursors / graphite-cursors / vanilla-dmz /
      # catppuccin-cursors / hackneyed-x11-cursors / openzone-cursors
      stylix.cursor = {
        name = cursors.dark;
        package = pkgs.phinger-cursors;
        size = 12;
        # name = "Posy_Cursor_Black";
        # package = pkgs.posy-cursors;
        # size = 32;
        # name = "Bibata-Modern-Classic";
        # package = pkgs.bibata-cursors;
        # size = 10;
      };

      stylix.targets.floorp.enable = false;
      stylix.targets.librewolf.enable = false;
      stylix.targets.firefox.profileNames = [
        "home"
        "work"
      ];
      stylix.targets.vscode.profileNames = [ "default" ];
      # FIXME: infinite recursion why?
      # stylix.targets.firefox.profileNames = builtins.attrNames config.programs.firefox.profiles;
      # stylix.targets.vscode.profileNames = builtins.attrNames config.programs.vscode.profiles;

      # TODO: move this to common aspect
      fonts.fontconfig.enable = true;
      fonts.fontconfig.defaultFonts = {
        monospace = lib.mkBefore [ config.stylix.fonts.monospace.name ];
        sansSerif = lib.mkBefore [ config.stylix.fonts.sansSerif.name ];
        serif = lib.mkBefore [ config.stylix.fonts.serif.name ];
      };

      dconf.settings = {
        "org/gnome/desktop/interface" = {
          # HACK: override stylix -- why does it set 'default'?
          # color-scheme = lib.mkForce "prefer-${prefs.theme.color.variant}";
        };
        "org/gnome/desktop/wm/preferences" = {
          titlebar-uses-system-font = true;
        };
      };

      home.packages = [
        pkgs.fastfetch # another neofetch clone
      ];
    }
  );
}
