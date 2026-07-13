{
  aspects.graphical.home =
    { pkgs, ... }:
    {
      services.flameshot.enable = true;

      home.packages = [
        pkgs.kooha
      ];
    };
}
