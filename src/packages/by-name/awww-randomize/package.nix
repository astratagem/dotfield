{
  coreutils,
  awww,
  writeShellApplication,
}:
writeShellApplication {
  name = "awww-randomize";
  runtimeInputs = [
    coreutils
    awww
  ];
  text = builtins.readFile ./script.sh;
}
