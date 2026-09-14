# SPDX-FileCopyrightText: (C) 2026 Chris Montgomery <chmont@protonmail.com>
# SPDX-License-Identifier: GPL-3.0-or-later
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
            size = "1G";
            type = "EF00";
            content = {
              type = "filesystem";
              format = "vfat";
              mountpoint = "/boot";
              mountOptions = [ "umask=0077" ];
              extraArgs = [
                "-n"
                "ESP"
              ];
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
                  "boschic"
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
                    mountOptions = [ "compress=zstd" ];
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
  flake.diskoConfigurations.boschic = layout;

  hosts.nixos.boschic.configuration =
    { lib, ... }:
    {
      imports = [ inputs.disko.nixosModules.disko ];
      inherit (layout) disko;

      fileSystems."/var/log".neededForBoot = true;

      # Scratch VMs from `vmWithDisko` have no sops keys, so every
      # `hashedPasswordFile` resolves to nothing and no password is accepted --
      # locking us out of the console we booted the VM to use.  This applies
      # only to that throwaway VM: the real system keeps `mutableUsers = false`
      # and its sops-backed passwords.  Nothing is revealed, since the VM's disk
      # is an empty qcow2 and anyone able to build it already has the repo.
      virtualisation.vmVariantWithDisko = {
        users.mutableUsers = lib.mkForce true;

        # `hashedPasswordFile` must be cleared as well, or it wins over
        # `initialPassword` and leaves the account locked.
        users.users.root.initialPassword = lib.mkForce "";
        users.users.seadoom.hashedPasswordFile = lib.mkForce null;
        users.users.seadoom.initialPassword = lib.mkForce "";

        # This VM exists to inspect the disk, not to run a desktop.  The
        # inherited graphical session does not come up under qemu, so boot
        # straight to a console instead of a greeter that cannot start.
        systemd.defaultUnit = lib.mkForce "multi-user.target";
      };
    };
}
