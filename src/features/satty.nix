{
  aspects.workstation.home = {
    programs.satty = {
      enable = true;
      # https://github.com/Satty-org/Satty#configuration-file
      settings = {
        # N.B. This should match the path used by Niri's
        # `screenshot-path` setting, with a suffix appended.
        # https://docs.rs/chrono/latest/chrono/format/strftime/index.html
        output-filename = "~/Pictures/Screenshots/screenshot-%Y%m%dT%H%M%S-annotated.png";

        auto-copy = true;
        copy-command = "wl-copy";
        corner-roundness = 12;
        early-exit = true;
        early-exit-save-as = false;
        # [possible values: pointer, crop, line, arrow, rectangle, text, marker, blur, brush]
        initial-tool = "arrow";
        resize.mode = "smart";
        save-after-copy = true;
      };
    };
  };
}
