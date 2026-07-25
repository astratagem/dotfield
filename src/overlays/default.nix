{ inputs, ... }:
{
  imports = [
    inputs.flake-parts.flakeModules.easyOverlay
  ];

  perSystem =
    { inputs', ... }:
    {
      # Pin heavy GUI/desktop packages to the stable channel, where they are less
      # prone to the build failures that hit them on unstable.  This is the only
      # cross-channel tree we instantiate: `ddev`/`zellij` (formerly pulled from
      # nixpkgs-trunk) now resolve from the host's own channel, so master is no
      # longer evaluated.
      overlayAttrs = {
        inherit (inputs'.nixos-stable.legacyPackages)
          calibre
          igrep
          inkscape
          wineasio
          winetricks
          wineWowPackages
          zx
          ;
      };
    };
}
