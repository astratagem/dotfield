{ self, ... }:
{
  aspects.core.nixos = {
    environment.pathsToLink = [ "/share/bash-completion" ];
  };

  aspects.core.home =
    { config, ... }:
    {
      imports = [
        self.modules.homeManager.bash-trampoline
      ];

      programs.bash = {
        enable = true;
        enableCompletion = true;
        sessionVariables = {
          "BASH_COMPLETION_USER_FILE" = "${config.xdg.dataHome}/bash/completion";
        };
      };
    };
}
