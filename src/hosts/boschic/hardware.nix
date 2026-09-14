# SPDX-FileCopyrightText: (C) 2026 Chris Montgomery <chmont@protonmail.com>
# SPDX-License-Identifier: GPL-3.0-or-later
{
  hosts.nixos.boschic.configuration = {
    boot.initrd.availableKernelModules = [
      "nvme"
      "xhci_pci"
      "ahci"
      "usb_storage"
      "usbhid"
      "sd_mod"
    ];
    boot.initrd.kernelModules = [ "kvm-amd" ];
    boot.extraModulePackages = [ ];
  };
}
