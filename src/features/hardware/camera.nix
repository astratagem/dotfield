{
  aspects.workstation.nixos =
    { pkgs, ... }:
    {
      environment.systemPackages = [
        pkgs.v4l-utils
      ];
    };
}
