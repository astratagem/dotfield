# SPDX-FileCopyrightText: (C) 2026 Chris Montgomery <chmont@protonmail.com>
#
# SPDX-License-Identifier: GPL-3.0-or-later

# Declarative disk layout for ryosuke, and its opt-in to disko.
#
# Unlike boschic, ryosuke is NOT being wiped, so this must *describe* the disk
# as it already exists, and hardware.nix stays authoritative
# (disko.enableConfig = false).  The two descriptions therefore coexist and
# can drift: `just disko-diff ryosuke` is what catches that.
#
# STATUS: verified by `just disko-diff ryosuke`.  All five btrfs subvolumes
# match the running config on fsType and mount options.  The ESP does NOT:
# this layout yields /dev/disk/by-partlabel/disk-main-ESP, while the live disk
# has an unlabelled ESP at /dev/disk/by-uuid/B368-8A84.  The btrfs devices
# likewise differ only in naming (/dev/mapper/enc vs by-label/nixos, the same
# filesystem reached two ways).
#
# Consequence: running disko against ryosuke as-is would reformat the ESP and
# assign a partlabel the current fileSystems block does not reference.  Before
# using this on real hardware, either partlabel the existing ESP to match, or
# switch hardware.nix's /boot to the partlabel -- then flip enableConfig on
# and delete the hand-written block, as boschic already does.
#
# Subvolumes carry an "@" prefix here, and /nix maps to "@store" -- not
# "@nix".  See src/hosts/ryosuke/hardware.nix.
{ inputs, ... }:
let
  layout = {
    disko.devices.disk.main = {
      type = "disk";
      # FIXME: confirm on the machine before running disko --
      #   ls -l /dev/disk/by-id/ | grep -v part
      device = "/dev/disk/by-id/CHANGE-ME";
      content = {
        type = "gpt";
        partitions = {
          ESP = {
            priority = 1;
            size = "512M";
            type = "EF00";
            content = {
              type = "filesystem";
              format = "vfat";
              mountpoint = "/boot";
              mountOptions = [ "umask=0077" ];
              # TODO: would this work?  for consistency
              # extraArgs = ["-n" "ESP"];
            };
          };

          swap = {
            priority = 2;
            size = "16G";
            content = {
              type = "swap";
              randomEncryption = false;
            };
          };

          luks = {
            size = "100%";
            content = {
              type = "luks";
              # Must match boot.initrd.luks.devices."enc" in hardware.nix.
              name = "enc";
              settings.allowDiscards = true;
              content = {
                type = "btrfs";
                extraArgs = [
                  "-L"
                  "nixos"
                ];
                subvolumes = {
                  "@root" = {
                    mountpoint = "/";
                    mountOptions = [
                      "compress=zstd"
                      "noatime"
                    ];
                  };
                  "@store" = {
                    mountpoint = "/nix";
                    mountOptions = [
                      "compress=zstd"
                      "noatime"
                    ];
                  };
                  "@log" = {
                    mountpoint = "/var/log";
                    mountOptions = [
                      "compress=zstd"
                      "noatime"
                    ];
                  };
                  "@home" = {
                    mountpoint = "/home";
                    mountOptions = [
                      "compress=zstd"
                      "noatime"
                    ];
                  };
                  "@persist" = {
                    mountpoint = "/persist";
                    mountOptions = [
                      "compress=zstd"
                      "noatime"
                    ];
                  };
                };
              };
            };
          };
        };
      };
    };
  };
in
{
  flake.diskoConfigurations.ryosuke = layout;

  hosts.nixos.ryosuke.configuration =
    { lib, ... }:
    {
      imports = [ inputs.disko.nixosModules.disko ];

      disko = layout.disko // {
        enableConfig = false;
      };

      virtualisation.vmVariantWithDisko = {
        users.mutableUsers = lib.mkForce true;
        users.users.root.initialPassword = lib.mkForce "";
      };
    };
}
