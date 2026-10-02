{ inputs, ... }: {
  aspects.workstation.nixos = {
    imports = [ inputs.hister.nixosModules.default ];
  };

  aspects.workstation.home =
    { config, ... }:
    let
      cfg = config.services.hister;
    in
    {
      imports = [ inputs.hister.homeModules.default ];

      services.hister.port = 4433;
      services.hister.settings.server = {
        address = "127.0.0.1:${builtins.toString cfg.port}";
        database = "db.sqlite3";
      };
    };
}
