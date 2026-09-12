# SPDX-FileCopyrightText: (C) 2026 Chris Montgomery <chmont@protonmail.com>
#
# SPDX-License-Identifier: GPL-3.0-or-later

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
