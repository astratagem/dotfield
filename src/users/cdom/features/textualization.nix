{
  aspects.workstation.home =
    { pkgs, ... }:
    {
      home.packages = [
        pkgs.zalgo # read stdin and corrupt it with combining diacritics
      ];
    };
}
