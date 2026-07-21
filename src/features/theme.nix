{ lib, ... }:
{
  aspects.graphical.nixos =
    { pkgs, ... }:
    let
      toColorSchemePath = scheme: "${pkgs.base16-schemes}/share/themes/${scheme}.yaml";
    in
    {
      stylix.enable = true;

      # Default to dark theme (base configuration before specialisation)
      stylix.base16Scheme = toColorSchemePath "penumbra-dark";

      specialisation = {
        dark.configuration = {
          stylix.base16Scheme = lib.mkForce (toColorSchemePath "penumbra-dark");
        };
        light.configuration = {
          stylix.base16Scheme = lib.mkForce (toColorSchemePath "penumbra-light");
        };
      };
    };

  aspects.graphical.home = {
    # Adopt the new default from NixOS 26.05+, regardless of system
    # state version.
    gtk.gtk4.theme = lib.mkDefault null;
  };
}
