{ moduleWithSystem, ... }:
{
  aspects.development.home = moduleWithSystem (
    perSystem@{ pkgs, inputs' }:
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
