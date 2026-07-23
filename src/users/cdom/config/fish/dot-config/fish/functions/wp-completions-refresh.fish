function wp-completions-refresh -d "Rebuild the cached WP-CLI completion tree for an env alias (e.g. @staging)"
  if test (count $argv) -ne 1
    echo "usage: wp-completions-refresh <alias>   # e.g. @staging" >&2
    return 2
  end
  set -l alias $argv[1]

  # The cache helpers live in the `wp` completion script, which Fish only
  # autoloads while completing `wp`. Source it so the helpers are defined here
  # regardless of completion-load order.
  set -l completions "$__fish_config_dir/completions/wp.fish"
  if not test -f $completions
    echo "wp completion script not found: $completions" >&2
    return 1
  end
  source $completions

  echo "Refreshing WP-CLI completion cache for $alias ..."
  if __wp_cli_cache_refresh $alias
    echo "Done: "(__wp_cli_cache_path $alias)
  else
    echo "Failed to refresh completions for $alias" >&2
    return 1
  end
end
