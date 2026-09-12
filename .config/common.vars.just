now := datetime('%+')
nowfs := datetime(time-format-denote)
time-format-denote := '%Y%m%dT%H%M%S%z'
today := datetime('%F')
open := if os_family() == "linux" { "xdg-open" } else { "open" }

# <https://datatracker.ietf.org/doc/html/rfc9562#name-nil-uuid>
uuid-nil := '00000000-0000-0000-0000-000000000000'

prj-root := env('PRJ_ROOT')
prj-config-home := env('PRJ_CONFIG_HOME', prj-root / ".config")
prj-cache-home := env('PRJ_CACHE_HOME', prj-root / ".cache")
prj-data-home := env('PRJ_DATA_HOME', prj-root / ".data")
prj-bin-home := env('PRJ_PATH', prj-root / ".bin")

owner-name := 'Chris Montgomery'
owner-handle := 'astratagem'
owner-email := 'chmont@protonmail.com'
owner-attr := owner-name + ' <' + owner-email + '>'

cachix-cache-name := 'dotfield'
cachix-jobs := '4'
cachix-exec := "cachix watch-exec " + cachix-cache-name + " --jobs " + cachix-jobs

current-user := env("USER")

user-configs-dir := prj-root / "src/users" / current-user / "config"
ironbar-dir := user-configs-dir / "ironbar/dot-config/ironbar"
