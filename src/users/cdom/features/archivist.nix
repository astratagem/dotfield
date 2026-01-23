{ moduleWithSystem, ... }:
{
  aspects.workstation.home = moduleWithSystem (
    perSystem@{ config }:
    { pkgs, ... }:
    {
      home.packages = [
        config.packages.aax-to-m4b

        pkgs.aaxtomp3
        pkgs.audible-cli
      ];
    }
  );
}
