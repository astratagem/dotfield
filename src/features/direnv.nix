{
  aspects.development.home =
    { lib, config, ... }:
    let
      inherit (lib) mkAfter mkIf;
      cfg = config.programs.direnv;
    in
    {
      programs.direnv.enable = true;
      programs.direnv.nix-direnv.enable = true;

      # HACK(https://github.com/nix-community/home-manager/issues/9387)
      programs.direnv.enableNushellIntegration = false;
      # Using `mkAfter` to make it more likely to appear after other
      # manipulations of the prompt.
      programs.nushell.extraConfig = mkIf cfg.enableNushellIntegration (mkAfter ''
        $env.config = ($env.config? | default {})
        $env.config.hooks = ($env.config.hooks? | default {})
        $env.config.hooks.pre_prompt = (
            $env.config.hooks.pre_prompt?
            | default []
            | append {||
                let direnv = (
                    ${lib.getExe.package} export json
                    | from json --strict
                    | default {}
                )

                for key in ($direnv | columns) {
                    if ($direnv | get $key) == null {
                        hide-env --ignore-errors $key
                    }
                }

                $direnv
                | items {|key, value|
                    let value = do (
                        {
                          "PATH": {
                            from_string: {|s| $s | split row (char esep) | path expand --no-symlink }
                            to_string: {|v| $v | path expand --no-symlink | str join (char esep) }
                          }
                        }
                        | merge ($env.ENV_CONVERSIONS? | default {})
                        | get ([[value, optional, insensitive]; [$key, true, true] [from_string, true, false]] | into cell-path)
                        | if ($in | is-empty) { {|x| $x} } else { $in }
                    ) $value
                    return [ $key $value ]
                }
                | where {|pair| $pair.1 != null }
                | into record
                | reject -i SHELL? shell? shellHook? builder? out? outputs? phases? stdenv? system? name?
                | load-env
            }
        )
      '');

    };
}
