# WP-CLI tab completions for fish, extended with environment-alias awareness.
#
# Upstream base: https://github.com/wp-cli/wp-cli/blob/776897923176304d813dae252799d1790c6a0cb6/utils/wp.fish
#
# The stock `wp cli completions` runs on WP-CLI's `before_wp_load` hook, so it
# never sees commands registered by plugins (those attach during WP bootstrap).
# It is also purely local, so it cannot reflect a remote environment's plugins.
#
# When the command line targets an environment alias (e.g. `wp @staging ...`),
# we instead complete from a cached, plugin-aware command tree fetched from that
# environment over SSH. The tree is produced by fully booting WordPress remotely
# and walking the command registry (see `__wp_cli_remote_fetch`). Because that
# round-trip costs several seconds, results are cached per-alias with a TTL and
# refreshed in the background so interactive completion stays instant.

set -g __wp_cli_cache_dir "$XDG_CACHE_HOME/wp-cli-completions"
# Seconds before a cached tree is considered stale and refreshed in background.
set -g __wp_cli_cache_ttl 86400
# This file's own path, so background refreshes can re-source the helpers
# (a bare `fish -c` does not autoload completion functions).
set -g __wp_cli_self (status filename)

# --- Local (default) completions -------------------------------------------

function __wp_cli_complete_local
    set --local COMP_LINE (commandline)
    set --local COMP_POINT (commandline -C)

    set --local opts (wp cli completions --line=$COMP_LINE --point=$COMP_POINT)

    if string match -qe "<file> " -- $opts
        command ls -1
    else
        string trim -- $opts
    end
end

# --- Alias detection --------------------------------------------------------

# Echo the environment alias (e.g. "@staging") if the current command line
# targets one, otherwise echo nothing. An alias is the first `@`-prefixed token
# following `wp`.
function __wp_cli_current_alias
    set --local tokens (commandline -opc)
    for tok in $tokens[2..]
        if string match -qr '^@' -- $tok
            echo $tok
            return 0
        end
    end
    return 1
end

# --- Remote fetch + cache ---------------------------------------------------

# Fetch the full, plugin-aware command tree for an alias as JSON on stdout.
# Boots WordPress remotely and walks the WP-CLI command registry;
# `error_reporting(0)` keeps theme/core deprecation notices out of the output.
function __wp_cli_remote_fetch --argument-names alias
    wp $alias eval '
        error_reporting(0);
        function __wp_dump($cmd) {
            $out = [];
            if (method_exists($cmd, "get_subcommands")) {
                foreach ($cmd->get_subcommands() as $name => $sub) {
                    $entry = ["name" => $name];
                    $children = __wp_dump($sub);
                    if (!empty($children)) $entry["subcommands"] = $children;
                    $out[] = $entry;
                }
            }
            return $out;
        }
        echo json_encode(__wp_dump(WP_CLI::get_root_command()));
    ' 2>/dev/null
end

# Short, stable identifier for the active WP-CLI project, so an alias like
# `@staging` in one project never shares a cache with the same alias name in
# another. An alias is only meaningful relative to the `wp-cli.yml` that defines
# it, so we key on the absolute path of the config file WP-CLI itself resolved
# (via `wp --info`, which honors `$PWD` and any `.local.yml` override). When
# there is no project config, fall back to a fixed "global" scope.
function __wp_cli_project_key
    set --local config (wp --info 2>/dev/null | string replace -rf '^WP-CLI project config:\s*' '')
    if test -z "$config"
        echo global
    else
        printf '%s' $config | sha256sum | string sub -l 16
    end
end

# Path to the cache file for an alias, scoped to the active project. The project
# key comes first so entries for the same project sort together, followed by the
# alias name (with its leading `@` stripped) so the cache directory stays legible.
function __wp_cli_cache_path --argument-names alias
    set --local slug (string replace -r '^@' '' -- $alias | string replace --all '/' '_')
    echo "$__wp_cli_cache_dir/"(__wp_cli_project_key)"-$slug.json"
end

# Rebuild the cache for an alias synchronously. Writes atomically so a
# concurrent reader never sees a half-written file, and only replaces the cache
# when the fetch produced valid, non-empty JSON.
function __wp_cli_cache_refresh --argument-names alias
    mkdir -p $__wp_cli_cache_dir
    set --local dest (__wp_cli_cache_path $alias)
    set --local tmp "$dest."(random)".tmp"
    if __wp_cli_remote_fetch $alias >$tmp 2>/dev/null
        and test -s $tmp
        and jq -e . $tmp >/dev/null 2>&1
        mv -f $tmp $dest
    else
        rm -f $tmp
        return 1
    end
end

# Return the cached tree JSON for an alias, refreshing as needed. If the cache
# is missing, fetch synchronously (unavoidable first-time cost). If it exists
# but is stale, return it immediately and refresh in the background.
function __wp_cli_cache_get --argument-names alias
    set --local cache (__wp_cli_cache_path $alias)

    if not test -f $cache
        __wp_cli_cache_refresh $alias >/dev/null 2>&1
        or return 1
    else
        set --local age (math (date +%s) - (path mtime $cache))
        if test $age -gt $__wp_cli_cache_ttl
            # Detached background refresh; current completion uses stale cache.
            # The subshell re-sources this file (completion functions are not
            # autoloaded outside completion) and inherits $PWD, so it resolves
            # the same project scope.
            fish -c "source $__wp_cli_self; __wp_cli_cache_refresh $alias" &>/dev/null &
            disown 2>/dev/null
        end
    end

    cat $cache 2>/dev/null
end

# --- Remote completion ------------------------------------------------------

# Given the cached tree JSON on stdin and the command-path tokens already typed
# after the alias as positional args, echo the candidate next tokens.
#
# The jq filter walks the tree one token at a time: starting from the array of
# top-level commands, each token selects the matching node and steps into its
# `subcommands`. An empty path lists the top level; an unknown token yields an
# empty set. `--args` must come last, and the tree is fed on stdin, because
# `--args` otherwise greedily swallows any trailing filename as a path token.
function __wp_cli_match_tree --argument-names tree_json
    printf '%s' $tree_json | jq -r '
        (reduce $ARGS.positional[] as $t (.;
            ([.[] | select(.name == $t) | .subcommands] | add) // []))
        | .[].name
    ' --args $argv[2..] 2>/dev/null
end

function __wp_cli_complete_remote
    set --local alias (__wp_cli_current_alias)
    or return 1

    set --local tree (__wp_cli_cache_get $alias)
    or return 1
    test -n "$tree"
    or return 1

    # Tokens after `wp` and the alias that form the command path so far.
    # `commandline -opc` excludes the token currently being typed.
    set --local tokens (commandline -opc)
    set --local path
    set --local seen_alias 0
    for tok in $tokens[2..]
        if test $seen_alias -eq 1
            set --append path $tok
        else if test "$tok" = "$alias"
            set seen_alias 1
        end
    end

    __wp_cli_match_tree $tree $path
end

# --- Dispatch ---------------------------------------------------------------

function __wp_cli_complete
    if __wp_cli_current_alias >/dev/null
        __wp_cli_complete_remote
    else
        __wp_cli_complete_local
    end
end

complete -f -a "(__wp_cli_complete)" wp
