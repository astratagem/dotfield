{
  aspects.graphical.home = { pkgs, ... }: {
    home.packages = [
      pkgs.imv
      pkgs.kdePackages.gwenview
      pkgs.qiv
      pkgs.swayimg
    ];
  };
}
