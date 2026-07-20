{
  aspects.development.home = { pkgs, ... }: {
    home.packages = [ pkgs.figlet ];

    programs.television.channels.figlet-fonts = {
      metadata = {
        description = "Browse and preview figlet fonts";
        name = "figlet-fonts";
        requirements = [ "figlet" ];
      };
      preview = {
        command = "figlet -f '{}' 'The quick brown fox jumps over the lazy dog.'";
      };
      source = {
        command = "for i in \"$(figlet -I2)\"/*.flf; do basename \"$i\" .flf; done | sort";
      };
    };
  };
}
