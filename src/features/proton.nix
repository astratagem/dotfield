{
  aspects.workstation.home =
    { pkgs, ... }:
    {
      # XXX(2025-11-14): build failure in proton-core
      # home.packages = with pkgs; [
      #   protonmail-bridge-gui
      #   protonvpn-gui
      # ];
    };
}
