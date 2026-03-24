{ inputs, ... }:
{
  imports = [
    inputs.flake-parts.flakeModules.easyOverlay
  ];

  perSystem =
    { inputs', ... }:
    {
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
        inherit (inputs'.nixpkgs-trunk.legacyPackages)
          zellij
          ;
      };
    };
}
