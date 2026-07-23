{ self, lib, ... }:
let
  inherit (self.lib.shell) cmd;
in
{
  users.cdom.aspects.core.home = (
    { pkgs, ... }:
    let
      dirPreviewCommand = "${lib.getExe pkgs.eza} --tree {} | head -n 200";
    in
    {
      programs.fzf = {
        defaultOptions = [
          "--ansi"
          "--reverse"
          "--border"
          "--inline-info"
          "--color=16"
        ];
        fileWidget.command = cmd pkgs.fd {
          type = "file";
          hidden = true;
          follow = true;
          exclude = [
            ".git"
            ".devenv"
            ".direnv"
            "node_modules"
            "vendor"
          ];
        };
        # TODO: use `bat` -- see `igr` package source for example (doesn't include `head`-like tho)
        fileWidget.options = [ "--preview 'head {}'" ];
        changeDirWidget.command = cmd pkgs.fd { "type" = "directory"; };
        changeDirWidget.options = [
          "--tiebreak=index"
          "--preview '${dirPreviewCommand}'"
        ];
        historyWidget.options = [
          "--sort"
          "--exact"
        ];
      };
    }
  );
}
