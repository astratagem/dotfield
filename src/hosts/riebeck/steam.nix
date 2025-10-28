{
  hosts.nixos.riebeck.configuration =
    { pkgs, ... }:
    {
      programs.steam = {
        enable = true;
        remotePlay.openFirewall = true;
        dedicatedServer.openFirewall = true;
      };
      environment.systemPackages = [
        pkgs.steam-run
      ];
    };
}
