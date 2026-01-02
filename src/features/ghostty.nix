{
  aspects.graphical.home = {
    programs.ghostty = {
      enable = true;
      enableBashIntegration = true;
      enableFishIntegration = true;
      installBatSyntax = true;
      settings = {
        keybind = [
          # HACK: Work around Claude Code Shift+Enter newline bug
          # https://github.com/anthropics/claude-code/issues/1282#issuecomment-3185584410
          "shift+enter=text:\x1b\r"
        ];
      };
    };
    dconf.settings."org/cinnamon/desktop/applications/terminal".exec = "ghostty";
  };
}
