{
  aspects.graphical.home = {
    programs.ghostty = {
      enable = true;
      enableBashIntegration = true;
      enableFishIntegration = true;
      installBatSyntax = true;
      settings = {
        keybind = [
          "shift+enter=text:\"\n\""
        ];
      };
    };
    dconf.settings."org/cinnamon/desktop/applications/terminal".exec = "ghostty";
  };
}
