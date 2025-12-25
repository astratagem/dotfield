{
  aspects.workstation.nixos =
    { pkgs, ... }:
    {
      services.usbmuxd.enable = true;
      services.usbmuxd.package = pkgs.usbmuxd;

      environment.systemPackages = [
        pkgs.libimobiledevice
        pkgs.ifuse
      ];
    };
}
