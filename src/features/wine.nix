{

  aspects.workstation.nixos =
    { pkgs, ... }:
    {
      environment.systemPackages = [
        pkgs.wineWowPackages.waylandFull

        pkgs.wineasio
        pkgs.winetricks
      ];
    };
}
