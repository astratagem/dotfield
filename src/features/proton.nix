{
  aspects.workstation.home =
    { pkgs, ... }:
    {
      home.packages = with pkgs; [
        proton-authenticator
        protonmail-bridge-gui
        protonvpn-gui
      ];
    };
}
