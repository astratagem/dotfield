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

      # HACK(https://github.com/NixOS/nixpkgs/pull/556080)
      linuxPackages_latest = prev.linuxPackages_latest.extend (
        _kfinal: kprev: {
          ddcci-driver = kprev.ddcci-driver.overrideAttrs (o: {
            postPatch = (o.postPatch or "") + ''
              sed -i 's/\bstrncpy(/strscpy(/g' ddcci/ddcci.c
            '';
          });
        }
      );
    };
}
