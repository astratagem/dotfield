{ moduleWithSystem, ... }:
{
  aspects.workstation.home = moduleWithSystem (
    perSystem@{ inputs' }:
    { pkgs, ... }:
    {
      home.packages = [
        perSystem.inputs'.llm-agents.packages.claude-desktop

        # TODO: The package variant should probably vary depending on
        # the host-specific hardware.
        pkgs.ollama
      ];
    }
  );

  aspects.development.home = moduleWithSystem (
    perSystem@{ inputs' }:
    {
      home.packages = with perSystem.inputs'.llm-agents.packages; [
        claude-plugins
      ];

      programs.claude-code = {
        enable = true;
        package = perSystem.inputs'.llm-agents.packages.claude-code;
      };
    }
  );
}
