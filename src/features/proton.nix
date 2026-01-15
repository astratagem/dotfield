{
  aspects.workstation.home =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        protonmail-bridge-gui
        protonvpn-gui
      ];
    };
}
