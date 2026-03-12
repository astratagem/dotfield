{
  aspects.workstation.home =
    { pkgs, ... }:
    {
      home.packages = [
        pkgs.darktable
        pkgs.dia
        pkgs.digikam
        pkgs.gimp-with-plugins
        pkgs.gthumb
        pkgs.hugin # image stitching (gui)
        pkgs.inkscape
        pkgs.scribus
        pkgs.shotwell
      ];
    };
}
