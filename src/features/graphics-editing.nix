{
  aspects.workstation.home =
    { pkgs, ... }:
    {
      home.packages = [
        pkgs.darktable
        # FIXME: 2026-07-20 failing build
        # pkgs.dia
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
