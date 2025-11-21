{
  users.cdom.aspects.development.home = {
    programs.jujutsu.settings = {
      aliases = {
        "examine" = [
          "log"
          "-T"
          "builtin_log_detailed"
          "-p"
          "-r"
        ];
        "l" = [
          "log"
          "--no-pager"
          "--limit=6"
        ];
        "s" = [
          "st"
          "--no-pager"
        ];
      };

      revsets = {
        # By default, show all my current stacks.
        log = "stack(mine() | @) | trunk() | @";
      };

      templates = {
        # FIXME: error │ 2: Value not found for ui.should-sign-off
        # draft_commit_description = ''
        #   concat(
        #     coalesce(description, default_commit_description, "\n"),
        #     if(
        #       config("ui.should-sign-off").as_boolean() && !description.contains("Signed-off-by: " ++ author.name()),
        #       "\nSigned-off-by: " ++ author.name() ++ " <" ++ author.email() ++ ">",
        #     ),
        #     "\n",
        #     surround(
        #       "\nJJ: This commit contains the following changes:\n", "",
        #       indent("JJ:     ", diff.summary()),
        #     ),
        #   )
        # '';

        op_log_node = "if(current_operation, \"@\", \"◉\")";
        log_node = ''
          label("node",
            coalesce(
              if(!self, label("elided", "⇋")),
              if(current_working_copy, label("working_copy", "◉")),
              if(conflict, label("conflict", "x")),
              if(immutable, label("immutable", "◆")),
              if(description.starts_with("wip: "), label("wip", "!")),
              label("normal", "○")
            )
          )
        '';
      };

      template-aliases = {
        # Display relative timestamps in log output
        "format_timestamp(timestamp)" = "timestamp.ago()";
      };

      ui = {
        movement.edit = true;
      };

      # https://gist.github.com/thoughtpolice/8f2fd36ae17cd11b8e7bd93a70e31ad6#file-jjconfig-toml-L182-L194
      colors = {
        "normal change_id" = {
          bold = true;
          fg = "magenta";
        };
        "immutable change_id" = {
          bold = false;
          fg = "bright cyan";
        };

        # Used by log node template
        "node" = {
          bold = true;
        };
        "node elided" = {
          fg = "bright black";
        };
        "node working_copy" = {
          fg = "green";
        };
        "node conflict" = {
          fg = "red";
        };
        "node immutable" = {
          fg = "bright cyan";
        };
        "node wip" = {
          fg = "yellow";
        };
        "node normal" = {
          bold = false;
        };

        "text link" = {
          bold = true;
          fg = "magenta";
        };
        "text warning" = {
          bold = true;
          # TODO: or yellow?
          fg = "red";
        };

      };
    };
  };
}
