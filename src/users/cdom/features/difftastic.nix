{
  users.cdom.aspects.development.home = {
    programs.git.settings.alias =
      let
        withDifft = s: "-c diff.external=difft ${s}";
      in
      {
        "dl" = withDifft "log -p --ext-diff";
        "ds" = withDifft "show --ext-diff";
        "dft" = withDifft "diff";
      };
  };
}
