{
  aspects.workstation.home =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        audacity
        sox
        # XXX(2025-11-14): build failure
        # tenacity
      ];
    };
}
