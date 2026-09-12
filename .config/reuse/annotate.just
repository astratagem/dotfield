import "../common.vars.just"

set no-cd

gpl3 := 'GPL-3.0-or-later'
mit := 'MIT'
and := ' AND '

alias default := annotate
alias public-domain := cc0

annotate license +ARGS:
    reuse annotate \
      --copyright-prefix spdx-c \
      --license '{{ license }}' \
      --copyright '{{ owner-attr }}' \
      --merge-copyrights \
      {{ ARGS }}

[doc("Annotate all unlicensed files")]
annotate-missing task:
    reuse lint --json \
    | jq -r '.non_compliant.missing_licensing_info.[]' \
    | xargs -n1 -I{} just reuse::annotate::{{ task }} {{ prj-root }}/{}

[doc("Annotate all plaintext note files with the documentation license")]
docs:
    fd --glob '**/*.{md,mdx,markdown,org}' -X just reuse::annotate::commons

[doc("License the specified files as GPL-3.0-or-later")]
gpl +FILES: (annotate gpl3 FILES)

[doc("Add a co-licensor to the specified files")]
colicense license colicensor +FILES: (annotate (license) ('-c ' + quote(colicensor) + ' ' + FILES))

[doc("License the specified files under an additional license")]
dual-license other-license +FILES: (annotate (gpl3 + and + other-license) FILES)

[doc("License the specified files as non-commercial docs (CC-BY-NC-SA-4.0)")]
commons +FILES: (annotate 'CC-BY-NC-SA-4.0' FILES)

[doc("Release the specified files into the public domain (CC0-1.0)")]
cc0 +FILES: (annotate 'CC0-1.0' FILES)
