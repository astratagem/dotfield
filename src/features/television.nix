{
  aspects.core.home = {
    programs.television.enable = true;
    programs.television.channels = {
      recent-files = {
        metadata = {
          description = "Recently modified files";
          name = "recent-files";
          requirements = [
            "bat"
            "fd"
          ];
        };
        preview = {
          command = "bat -n --color=always '{}'";
        };
        source = {
          command = "fd -t f --changed-within 7d";
        };
      };
    };
  };
}
