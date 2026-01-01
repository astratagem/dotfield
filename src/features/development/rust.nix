{
  aspects.development.home =
    { pkgs, ... }:
    {
      home.packages = [
        pkgs.bacon
        pkgs.rust-analyzer
        pkgs.rustc
        pkgs.rustfmt
        pkgs.rustlings
      ];
    };
}
