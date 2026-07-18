{ lib, ... }:
{
  aspects.development.home =
    { config, pkgs, ... }:
    {
      programs.mergiraf.enable = true;
      programs.mergiraf.enableGitIntegration = true;
      programs.mergiraf.enableJujutsuIntegration = true;

      programs.television.channels = {
        nix-search = {
          metadata = {
            name = "nix-search";
            requirements = [ "nix-search-tv" ];
          };
          preview = {
            command = "nix-search-tv preview {}";
          };
          source = {
            command = "nix-search-tv print";
          };
        };
      };

      home.packages =
        let
          dataWrangling = [
            pkgs.miller
            pkgs.tidy-viewer # `tv` => Pretty-print CSV files
            pkgs.xml2 # Tools for command line processing of XML, HTML, and CSV
            pkgs.xq-xml # XML formatter and scraper
          ];

          packagingTools = [
            pkgs.dpkg
          ];

          nixTools = [
            pkgs.nix-init
            pkgs.nix-inspect
            pkgs.nix-search-tv
            pkgs.nix-update
            pkgs.nixfmt
            pkgs.nixpkgs-review
          ];

          languageServers = [ pkgs.jq-lsp ];
        in
        dataWrangling
        ++ nixTools
        ++ languageServers
        ++ [
          pkgs.asciinema
          pkgs.ast-grep
          pkgs.copier
          pkgs.jira-cli-go
          pkgs.jiratui
          # Although git hooks should obviously be managed on a
          # per-project basis, `jj-git-push` expects the `pre-commit`
          # binary to be available (normally it is not).
          pkgs.pre-commit
          pkgs.quicktype # json schema toolkit
          pkgs.skate
          pkgs.universal-ctags
          pkgs.zx
        ];

      # NOTE: This will significantly slow down builds.  However, it enables more
      # manpage integrations across various tools (e.g. `apropos`, `man -k`).
      programs.man.generateCaches = true;
    };
}
