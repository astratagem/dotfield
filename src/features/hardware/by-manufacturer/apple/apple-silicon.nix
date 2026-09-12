# SPDX-FileCopyrightText: (C) 2026 Chris Montgomery <chmont@protonmail.com>
#
# SPDX-License-Identifier: GPL-3.0-or-later

{ inputs, lib, ... }:
{
  aspects.hardware__apple__apple-silicon = {
    overlays = [ inputs.nixos-apple-silicon.overlays.default ];

    nixos = { pkgs, ... }: {
      imports = [
        inputs.nixos-apple-silicon.nixosModules.apple-silicon-support
      ];

      environment.systemPackages = [ pkgs.nvtopPackages.apple ];

      hardware.asahi.enable = true;

      # U-Boot does not support EFI variables.
      boot.loader.efi.canTouchEfiVariables = lib.mkForce false;
      # U-Boot does not support switching console mode.
      boot.loader.systemd-boot.consoleMode = lib.mkForce "0";

      # Mutually exclusive legacy Apple hardware.
      hardware.facetimehd.enable = lib.mkForce false;
      services.mbpfan.enable = lib.mkForce false;
    };
  };
}
