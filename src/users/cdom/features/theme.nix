{ moduleWithSystem, self, ... }:
let
  inherit (self.lib.theme) polarity toColorSchemePath;
in
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

      schemes = {
        dark = "penumbra-dark";
        light = "penumbra-light";
      };

      cursors = {
        dark = "Hackneyed";
        light = "Hackneyed";
        # dark = "phinger-cursors-dark";
        # light = "phinger-cursors-light";
      };

      wallpapers = {
        dark = "dark/rougier--recursive-voronoi--inverted.png";
        light = "light/rougier--recursive-voronoi.png";
      };
    in
    {
      stylix.enable = true;

      # Select the active theme at build time (see `self.lib.theme.polarity`).
      # Formerly a dark/light specialisation pair; now a single evaluated theme.
      stylix.base16Scheme = toColorSchemePath pkgs schemes.${polarity};

      services.wpaperd.settings.any.path = "${wallpaperDir}/${wallpapers.${polarity}}";

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
        };

        serif = {
          name = "NewComputerModern10";
          package = pkgs.newcomputermodern;
        };

        monospace = {
          name = "Aporetic Sans Mono";
          package = pkgs.aporetic;
        };
      };

      # TODO: remove when merged: <https://github.com/nix-community/stylix/pull/2407>
      home.pointerCursor.enable = true;
      # alternatively: posy-cursors / graphite-cursors / vanilla-dmz /
      # catppuccin-cursors / hackneyed-x11-cursors / openzone-cursors
      stylix.cursor = {
        name = cursors.${polarity};
        package = pkgs.hackneyed;
        size = 24;
        # name = cursors.dark;
        # package = pkgs.phinger-cursors;
        # size = 12;
        # name = "Posy_Cursor_Black";
        # package = pkgs.posy-cursors;
        # size = 32;
        # name = "Bibata-Modern-Classic";
        # package = pkgs.bibata-cursors;
        # size = 10;
      };

      stylix.targets.floorp.enable = false;
      stylix.targets.librewolf.enable = false;
      stylix.targets.firefox.profileNames = [ "primary" ];
      stylix.targets.vscode.profileNames = [ "default" ];

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
