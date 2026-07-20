{
  aspects.workstation.nixos =
    { pkgs, ... }:
    {
      environment.systemPackages = [
        pkgs.wineWow64Packages.waylandFull

        pkgs.wineasio
        pkgs.winetricks
      ];
    };
}
