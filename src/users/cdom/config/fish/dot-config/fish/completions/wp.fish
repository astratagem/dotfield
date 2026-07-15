# https://gist.github.com/peterjaffray/0f2bdc0b297a87d5aada90e62816e11d

function __wp_complete
    set -l old_ifs $IFS
    set -l cur (commandline -ct)

    set IFS \n
    set -l opts (wp cli completions --line=(commandline) --point=(commandline -C))

    if string match -q --regex "\<file\>\s*" $opts
        return (commandline -f)
    else if test -z "$opts"
        return (commandline -f)
    else
        for opt in $opts
            printf '%s\n' $opt
        end
    end

    set IFS $old_ifs
end

complete -c wp -f -a "(__wp_complete)"
