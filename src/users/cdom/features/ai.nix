{ moduleWithSystem, ... }:
{
  users.cdom.aspects.workstation.home = moduleWithSystem (
    perSystem@{ pkgs, inputs' }:
    {
      home.packages = [
        pkgs.aider-chat-full
        pkgs.mods # https://github.com/charmbracelet/mods
      ]
      ++ (with perSystem.inputs'.nix-ai-tools.packages; [
        claude-code
        crush
      ]);
    }
  );
}
