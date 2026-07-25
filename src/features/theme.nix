{ lib, self, ... }:
let
  inherit (self.lib.theme) polarity toColorSchemePath;
in
{
  aspects.graphical.nixos =
    { pkgs, ... }:
    {
      stylix.enable = true;

      # Select the active theme at build time (see `self.lib.theme.polarity`).
      # Formerly a dark/light specialisation pair; now a single evaluated theme.
      stylix.base16Scheme = toColorSchemePath pkgs "penumbra-${polarity}";
    };

  aspects.graphical.home = {
    # Adopt the new default from NixOS 26.05+, regardless of system
    # state version.
    gtk.gtk4.theme = lib.mkDefault null;
  };
}
