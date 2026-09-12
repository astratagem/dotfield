# SPDX-FileCopyrightText: (C) 2026 Chris Montgomery <chmont@protonmail.com>
#
# SPDX-License-Identifier: GPL-3.0-or-later

{
  aspects.hardware__amd__cpu.nixos =
    { config, lib, ... }:
    {
      boot.kernelModules = lib.optional config.virtualisation.libvirtd.enable "kvm-amd";
      hardware.cpu.amd.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
    };
}
