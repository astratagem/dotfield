{
  aspects.graphical.home =
    { config, ... }:
    {
      services.wpaperd = {
        enable = true;
        settings = {
          default.mode = "fit-border-color";
        };
      };
    };
}
