{ inputs, ... }:
{
  flake.overlays.default =
    final: prev:
    let
      inherit (final.stdenv.hostPlatform) system;

      nixos-stable = inputs.nixos-stable.legacyPackages.${system};
    in
    {
      inherit (nixos-stable)
        calibre
        igrep
        inkscape
        wineasio
        winetricks
        wineWowPackages
        zx
        ;
    };
}
