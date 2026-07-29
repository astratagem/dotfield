{
  aspects.graphical.home =
    { pkgs, ... }:
    {
      home.packages = [
        pkgs.colorpanes # <- print panes in the 8 bright terminal colors with shadows of the respective darker color
        pkgs.pastel # <- generate, analyze, convert and manipulate colors
      ];
    };
}
