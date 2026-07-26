{
  aspects.development.home = {
    programs.jujutsu.settings.aliases = {
      cat = [
        "file"
        "show"
      ];

      credit = [
        "file"
        "annotate"
      ];

      # SYNOPSIS: jj eject <revset>
      # The inverse of harvest.
      "eject" = [
        "squash"
        "--from"
        "@"
        "--into"
      ];

      # SYNOPSIS: jj harvest <revset>
      # The inverse of eject.
      "harvest" = [
        "squash"
        "--into"
        "@"
        "--from"
      ];

      init = [
        "util"
        "exec"
        "--"
        "bash"
        "-c"
        ''
          jj git init --colocate
          jj bookmark track 'glob:*@origin'
        ''
      ];

      open = [
        "log"
        "-r"
        "open()"
      ];

      # https://github.com/acarapetis/jj-pre-push?tab=readme-ov-file#installation
      push = [
        "util"
        "exec"
        "--"
        "jj-pre-push"
        "push"
      ];

      retrunk = [
        "rebase"
        "-d"
        "trunk()"
      ];

      streamline = [ "simplify-parents" ];

      # Find the closest ancestor with a bookmark pointing at it,
      # and move it to the parent of the working copy.
      tug = [
        "bookmark"
        "move"
        "--from"
        "heads(::@- & bookmarks())"
        "--to"
        "@-"
      ];
    };
  };
}
