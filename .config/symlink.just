[doc("Replace a symlink to a Nix store file with a writeable copy of the file contents")]
derealise path:
    if [[ ! -L "{{ path }}" ]]; then \
        {{ error('Not a symlink: {{ symlink }}') }}; \
    fi
    if [[ ! -d "{{ path }}" ]]; then \
        cp --backup --suffix ".realised.bak" --copy-contents --verbose --remove-destination \
            "$(readlink "{{ path }}")" \
            "{{ path }}"; \
        chmod --changes 644 "{{ path }}"; \
    fi

[doc("Restore the original Nix store link backed up during derealisation")]
realise path:
    if [[ ! -L "{{ path }}.realised.bak" ]]; then \
        {{ error('Realisation not found: {{ derealised }}.realised.bak') }}; \
    fi
    mv --backup --suffix ".derealised.bak" --verbose \
        "{{ path }}.realised.bak" \
        "{{ path }}"
