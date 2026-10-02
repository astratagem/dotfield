{
  users.cdom.aspects.workstation.home = {
    services.hister.enable = true;
    services.hister.settings = {
      app = {
        search_url = "https://kagi.com/search?q={query}";
        log_level = "info";
      };
      hotkeys.web = {
        "/" = "focus_search_input";
        "enter" = "open_result";
      };
    };
  };
}
