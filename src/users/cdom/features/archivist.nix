{
  aspects.workstation.home =
    { pkgs, ... }:
    {
      home.packages = [
        pkgs.aaxtomp3
        pkgs.audible-cli
        pkgs.libation
      ];
    };
}
