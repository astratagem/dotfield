{
  aspects.graphical.nixos =
    { lib, pkgs, ... }:
    let
      toColorSchemePath = scheme: "${pkgs.base16-schemes}/share/themes/${scheme}.yaml";
    in
    {
      stylix.enable = true;

      # Default to dark theme (base configuration before specialisation)
      stylix.base16Scheme = toColorSchemePath "catppuccin-mocha";

      specialisation = {
        dark.configuration = {
          stylix.base16Scheme = lib.mkForce (toColorSchemePath "catppuccin-mocha");
        };
        light.configuration = {
          stylix.base16Scheme = lib.mkForce (toColorSchemePath "catppuccin-latte");
        };
      };
    };

  aspects.graphical.home = {
    # Adopt the new default from NixOS 26.05+, regardless of system
    # state version.
    gtk.gtk4.theme = null;
  };
}
