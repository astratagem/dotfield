# SPDX-FileCopyrightText: (C) 2026 Chris Montgomery <chmont@protonmail.com>
#
# SPDX-License-Identifier: GPL-3.0-or-later

# Display x509 certificates for an HTTPS URL
# Source: https://git.j3s.sh/dotfiles/blob/main/bin/getcert
{ openssl, writeShellApplication }:

writeShellApplication {
  name = "getcert";
  runtimeInputs = [ openssl ];

  text = ''
    url="$1"
    parsed_url=$(printf "%s" "$url" | sed 's|https://||g')

    printf '\n' \
    | openssl s_client -connect "$parsed_url":443 -showcerts \
    | openssl x509 -noout -text
  '';
}
