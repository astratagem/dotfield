{
  users.cdom.aspects.core.home = {
    programs.git.aliases = {
      # <https://stackoverflow.com/a/4408378/1801260>
      "reset-permissions" = ''
        !git diff -p -R --no-ext-diff --no-color --diff-filter=M \
        | grep -E "^(diff|(old|new) mode)" --color=never \
        | git apply
      '';
    };
    programs.git.extraConfig = {
      apply.whitespace = "nowarn";
      pull.rebase = true;
      merge.tool = "ediff";
      diff = {
        algorithm = "histogram";
        colorMoved = "dimmed-zebra";
        tool = "ediff";
      };
    };
  };
}
