{
  aspects.workstation.nixos =
    { pkgs, config, ... }:
    {
      services.printing = {
        enable = true;
        drivers = [
          pkgs.cups-browsed
          pkgs.cups-filters
          pkgs.hplip
        ];
      };

      services.avahi.openFirewall = true;

      # scanner support
      hardware.sane = {
        enable = true;
        openFirewall = true;
      };

      users.groups.cups = { inherit (config.users.groups.wheel) members; };
      users.groups.lp = { inherit (config.users.groups.wheel) members; };
      users.groups.scanner = { inherit (config.users.groups.wheel) members; };
    };
}
