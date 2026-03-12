{ lib, ... }:
let
  cmd =
    pkg: args:
    lib.concatStringsSep " " [
      (lib.getExe pkg)
      (toString (lib.cli.toCommandLineGNU { } args))
    ];
in
{
  flake.lib.shell = {
    inherit cmd;
  };
}
