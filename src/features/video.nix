{
  aspects.workstation.home =
    { pkgs, ... }:
    {
      home.packages = [
        pkgs.wl-mirror
      ];
    };
}
