{
  aspects.workstation.home =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        sox
        # XXX(2025-11-14): build failure
        # tenacity
      ];
    };
}
