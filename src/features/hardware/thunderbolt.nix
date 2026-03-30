{
  aspects.hardware__thunderbolt.nixos =
    { pkgs, ... }:
    {
      services.hardware.bolt.enable = true;

      environment.systemPackages = [
        pkgs.kdePackages.plasma-thunderbolt
      ];
    };
}
