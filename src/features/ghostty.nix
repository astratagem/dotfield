{
  aspects.graphical.home = {
    programs.ghostty = {
      enable = true;
      enableBashIntegration = true;
      enableFishIntegration = true;
      installBatSyntax = true;
      settings = {
        keybind = [ ];
        # https://gist.github.com/jake-stewart/0a8ea46159a7da2c808e5be2177e1783
        palette-generate = true;
      };
    };
    dconf.settings."org/cinnamon/desktop/applications/terminal".exec = "ghostty";
  };
}
