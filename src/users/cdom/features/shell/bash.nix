{ lib, ... }:
{
  users.cdom.aspects.core.home =
    { config, pkgs, ... }:
    let
      shellAbbrs = import ./__abbrs.nix { inherit pkgs; };
    in
    {
      programs.bash = {
        shellAliases = shellAbbrs;
        shellOptions = lib.mkOptionDefault [
          "cdspell"
          "dirspell"
          "histreedit"
          "histverify"
        ];
        historyFileSize = 100000;
        historySize = 100000;
        historyControl = [
          "erasedups"
          "ignorespace"
        ];
        historyIgnore = [
          "l"
          "x"
          "exit"
          "bg"
          "fg"
          "history"
          "poweroff"
          "ls"
          "cd"
          ".."
          "..."
        ];

        initExtra = lib.mkAfter ''
          # Must C-d at least thrice to close shell.
          export IGNOREEOF=2
        '';
      };
    };
}
