function __complete_aws-sso
    set -lx COMP_LINE (commandline -cp)
    test -z (commandline -ct)
    and set COMP_LINE "$COMP_LINE "
    export __NO_ESCAPE_COLONS=1
    {{ .Executable }}
end
complete -f -c aws-sso -a "(__complete_aws-sso)"

function __aws_sso_profile_complete
  set --local _args (string split -- ' ' $AWS_SSO_HELPER_ARGS)
  set -q AWS_SSO_HELPER_ARGS; or set --local _args -L error
  set -l cur (commandline -t)

  set -l cmd "{{ .Executable }} list $_args --csv -P Profile=$cur Profile"
  for completion in (eval $cmd)
    printf "%s\n" $completion
  end
end
complete -f -c aws-sso-profile -f -a '(__aws_sso_profile_complete)'
