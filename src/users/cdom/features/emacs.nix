{ lib, moduleWithSystem, ... }:
{
  users.cdom.aspects.development.home = moduleWithSystem (
    perSystem@{ inputs' }:
    home@{ pkgs, ... }:
    let
      sessionVariables = {
        EDITOR = lib.getExe perSystem.inputs'.ceamx.packages.editor;
      };
    in
    {
      # The single Emacs toggle: enabling ceamx also turns on `programs.emacs`,
      # the emacs-unstable-pgtk package, and the emacs-overlay for this user
      # (wired in src/features/emacs.nix).
      programs.emacs.ceamx.enable = true;

      home = { inherit sessionVariables; };
      programs.bash = { inherit sessionVariables; };
      programs.nushell.settings.buffer_editor = [ "emacsclient -tc" ];
    }
  );
}
