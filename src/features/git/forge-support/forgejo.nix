{
  aspects.development.home = { pkgs, ... }: {
    home.packages = [ pkgs.forgejo-cli ];

    programs.television.channels.fj-issues = {
      actions = {
        close = {
          command = "fj issue close {strip_ansi|split:\t:0|replace:s/^#//}";
          description = "Close the selected issue";
          mode = "fork";
        };
        comment = {
          command = "fj issue comment {strip_ansi|split:\t:0|replace:s/^#//}";
          description = "Add a comment to the selected issue";
          mode = "execute";
        };
        open = {
          command = "fj issue browse {strip_ansi|split:\t:0|replace:s/^#//}";
          description = "Open the issue in the browser";
          mode = "fork";
        };
      };
      metadata = {
        description = "List Forgejo issues for the current repo";
        name = "fj-issues";
        requirements = [
          "fj"
          "bat"
        ];
      };
      preview = {
        command = "fj issue view {strip_ansi|split:\t:0|replace:s/^#//} | bat --language=md --style=plain --color=always";
        env = {
          BAT_THEME = "ansi";
        };
      };
      source = {
        ansi = true;
        command = "fj issue search --state open | awk -F ' [(]by ' '/^\n  number=$1; sub(/^                                    \n  title=$1; sub(/^                    \n  author=$2; sub(/\\)$/,\"\",author)\n  printf \"\\033[32m#%s\\033[39m\\t%s \\033[33m@%s\\033[39m\\n\", number, title, author\n}' ";
        output = "{strip_ansi|split:\t:0|replace:s/^#//}";
      };
      ui = {
        layout = "portrait";
        preview_panel = {
          header = "{strip_ansi|split:\\t:1}";
        };
      };
    };

    programs.television.channels.fj-prs = {
      actions = {
        checkout = {
          command = "fj pr checkout {strip_ansi|split:\t:0|replace:s/^#//}";
          description = "Checkout the PR branch locally";
          mode = "execute";
        };
        diff = {
          command = "fj pr view {strip_ansi|split:\t:0|replace:s/^#//} diff | less";
          description = "View the PR diff";
          mode = "execute";
        };
        merge = {
          command = "fj pr merge {strip_ansi|split:\t:0|replace:s/^#//}";
          description = "Merge the selected PR";
          mode = "execute";
        };
        open = {
          command = "fj pr browse {strip_ansi|split:\t:0|replace:s/^#//}";
          description = "Open the PR in the browser";
          mode = "fork";
        };
      };
      metadata = {
        description = "List Forgejo PRs for the current repo";
        name = "fj-prs";
        requirements = [
          "fj"
          "bat"
        ];
      };
      preview = {
        command = "fj pr view {strip_ansi|split:\t:0|replace:s/^#//} | bat --language=md --style=plain --color=always";
        env = {
          BAT_THEME = "ansi";
        };
      };
      source = {
        ansi = true;
        command = "fj pr search --state open | awk -F ' [(]by ' '/^\n  number=$1; sub(/^                                    \n  title=$1; sub(/^                    \n  author=$2; sub(/\\)$/,\"\",author)\n  printf \"\\033[32m#%s\\033[39m\\t%s \\033[33m@%s\\033[39m\\n\", number, title, author\n}' ";
        output = "{strip_ansi|split:\t:0|replace:s/^#//}";
      };
      ui = {
        layout = "portrait";
        preview_panel = {
          header = "{strip_ansi|split:\\t:1}";
        };
      };
    };
  };
}
