{
  aspects.workstation = {
    nixos = {
      # Trust certificates produced by Proton Mail Bridge.
      security.pki.certificates = [ (builtins.readFile ./protonmail-bridge-cert.pem) ];
    };

    home =
      { pkgs, ... }:
      {
        home.packages = with pkgs; [
          proton-authenticator
          proton-vpn
          protonmail-bridge-gui
        ];
      };
  };
}
