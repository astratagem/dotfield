{
  aspects.workstation.nixos =
    { config, pkgs, ... }:
    {
      environment.systemPackages = [
        pkgs.android-file-transfer
      ];

      users.groups.adbusers = { inherit (config.users.groups.wheel) members; };
    };
}
