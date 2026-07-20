flake@{ inputs, lib, ... }:
let
  inherit (inputs.apparat.lib) isEmpty;
in
{
  aspects.development.home =
    { config, pkgs, ... }:
    let
      inherit (flake.config.meta.users.${config.home.username}) whoami;
    in
    lib.mkMerge [
      {
        home.packages = [
          pkgs.gh
          pkgs.hub
        ];

        programs.gh.enable = true;
        programs.gh.settings.git_protocol = lib.mkDefault "ssh";

        programs.television.channels = {
          gh-issues = {
            actions = {
              close = {
                command = "gh issue close {strip_ansi|split:#:1|split: :0}";
                description = "Close the selected issue";
                mode = "fork";
              };
              comment = {
                command = "gh issue comment {strip_ansi|split:#:1|split: :0}";
                description = "Add a comment to the selected issue";
                mode = "execute";
              };
              open = {
                command = "gh issue view {strip_ansi|split:#:1|split: :0} --web";
                description = "Open the issue in the browser";
                mode = "fork";
              };
            };
            metadata = {
              description = "List GitHub issues for the current repo";
              name = "gh-issues";
              requirements = [
                "gh"
                "jq"
              ];
            };
            preview = {
              command = "gh issue view '{strip_ansi|split:\n\"  \" + .title,\n\"  #\" + (.number | tostring),\n\"\",\n\"  \\u001b[36mStatus:\\u001b[39m \\u001b[32m\" + .state + \"\\u001b[39m\",\n\"  \\u001b[36mAuthor:\\u001b[39m \\u001b[33m\" + .author.login + \"\\u001b[39m\",\n\"  \\u001b[36mCreated:\\u001b[39m \" + (.createdAt | fromdateiso8601 | (now - .) | if . < 3600 then (./60|floor|tostring) + \" minutes ago\" elif . < 86400 then (./3600|floor|tostring) + \" hours ago\" else (./86400|floor|tostring) + \" days ago\" end),\n\"  \\u001b[36mUpdated:\\u001b[39m \" + (.updatedAt | fromdateiso8601 | (now - .) | if . < 3600 then (./60|floor|tostring) + \" minutes ago\" elif . < 86400 then (./3600|floor|tostring) + \" hours ago\" else (./86400|floor|tostring) + \" days ago\" end),\n(if (.labels | length) > 0 then \"  \\u001b[36mLabels:\\u001b[39m \" + ([.labels[] | \"\\u001b[35m\" + .name + \"\\u001b[39m\"] | join(\" \")) else \"\" end),\n(if (.assignees | length) > 0 then \"  \\u001b[36mAssignees:\\u001b[39m \" + ([.assignees[].login] | join(\", \")) else \"\" end),\n\"\",\n\"  \\u001b[90m────────────────────────────────────────────────────────────\\u001b[39m\",\n\"\",\n(.body // \"\")'\n";
            };
            source = {
              ansi = true;
              command = "gh issue list --state open --limit 100 --json number,title,createdAt,author,labels | jq -r 'sort_by(.createdAt) | reverse | .[] | \"  \\u001b[32m#\\(.number)\\u001b[39m   \\(.title) \\u001b[33m@\\(.author.login)\\u001b[39m\" + (if (.labels | length) > 0 then \" \" + ([.labels[] | \"\\u001b[35m\" + .name + \"\\u001b[39m\"] | join(\" \")) else \"\" end)'\n";
              output = "{strip_ansi|split:#:1|split: :0}";
            };
            ui = {
              layout = "portrait";
              preview_panel = {
                header = "{strip_ansi|split:#:1|split: :0}";
              };
            };
          };

          gh-prs = {
            actions = {
              checkout = {
                command = "gh pr checkout {strip_ansi|split:#:1|split:   :0}";
                description = "Checkout the PR branch locally";
                mode = "execute";
              };
              diff = {
                command = "gh pr diff {strip_ansi|split:#:1|split:   :0} | less";
                description = "View the PR diff";
                mode = "execute";
              };
              merge = {
                command = "gh pr merge {strip_ansi|split:#:1|split:   :0}";
                description = "Merge the selected PR";
                mode = "execute";
              };
              open = {
                command = "gh pr view {strip_ansi|split:#:1|split:   :0} --web";
                description = "Open the PR in the browser";
                mode = "execute";
              };
            };
            metadata = {
              description = "List GitHub PRs for the current repo";
              name = "gh-prs";
              requirements = [
                "gh"
                "jq"
              ];
            };
            preview = {
              command = "gh pr view '{strip_ansi|split:\n\"  \" + .title,\n\"  #\" + (.number | tostring),\n\"\",\n\"  \\u001b[36mStatus:\\u001b[39m \\u001b[32m\" + .state + \"\\u001b[39m  \" + .baseRefName + \" ← \" + .headRefName,\n\"  \\u001b[36mRepo:\\u001b[39m \\u001b[34m\" + (.headRepositoryOwner.login) + \"/\" + (.headRepository.name) + \"\\u001b[39m\",\n\"  \\u001b[36mAuthor:\\u001b[39m \\u001b[33m\" + .author.login + \"\\u001b[39m\",\n\"  \\u001b[36mCreated:\\u001b[39m \" + (.createdAt | fromdateiso8601 | (now - .) | if . < 3600 then (./60|floor|tostring) + \" minutes ago\" elif . < 86400 then (./3600|floor|tostring) + \" hours ago\" else (./86400|floor|tostring) + \" days ago\" end),\n\"  \\u001b[36mUpdated:\\u001b[39m \" + (.updatedAt | fromdateiso8601 | (now - .) | if . < 3600 then (./60|floor|tostring) + \" minutes ago\" elif . < 86400 then (./3600|floor|tostring) + \" hours ago\" else (./86400|floor|tostring) + \" days ago\" end),\n(if (.labels | length) > 0 then \"  \\u001b[36mLabels:\\u001b[39m \" + ([.labels[] | \"\\u001b[35m\" + .name + \"\\u001b[39m\"] | join(\" \")) else \"\" end),\n\"  \\u001b[36mMerge Status:\\u001b[39m \" + (if .mergeable == \"MERGEABLE\" then \"\\u001b[32m✓ Clean\\u001b[39m\" elif .mergeable == \"CONFLICTING\" then \"\\u001b[31m✗ Dirty\\u001b[39m\" else \"\\u001b[33m? Unknown\\u001b[39m\" end),\n\"  \\u001b[36mChanges:\\u001b[39m \" + (.changedFiles | tostring) + \" files  \\u001b[32m+\" + (.additions | tostring) + \"\\u001b[39m \\u001b[31m-\" + (.deletions | tostring) + \"\\u001b[39m\",\n\"\",\n\"  \\u001b[90m────────────────────────────────────────────────────────────\\u001b[39m\",\n\"\",\n(.body // \"\")'\n";
            };
            source = {
              ansi = true;
              command = "gh pr list --state open --limit 100 --json number,title,createdAt,author,labels | jq -r 'sort_by(.createdAt) | reverse | .[] | \"  \\u001b[32m#\\(.number)\\u001b[39m   \\(.title) \\u001b[33m@\\(.author.login)\\u001b[39m\" + (if (.labels | length) > 0 then \" \" + ([.labels[] | \"\\u001b[35m\" + .name + \"\\u001b[39m\"] | join(\" \")) else \"\" end)'\n";
              output = "{strip_ansi|split:#:1|split:   :0}";
            };
            ui = {
              layout = "portrait";
            };
          };
        };
      }
      (lib.mkIf (!isEmpty (whoami.accounts.github or false)) {
        programs.git.settings.github.user = whoami.accounts.github;
      })
    ];
}
