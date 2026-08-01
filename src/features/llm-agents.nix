{ moduleWithSystem, ... }:
{
  aspects.workstation.home = moduleWithSystem (
    perSystem@{ inputs' }:
    {
      home.packages = [
        perSystem.inputs'.llm-agents.packages.claude-desktop
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
