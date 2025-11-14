{
  aspects.workstation.home =
    { pkgs, ... }:
    {
      home.packages = [
        pkgs.calibre
        # XXX(2025-11-14): build failure
        # pkgs.mcomix
      ];
    };
}
