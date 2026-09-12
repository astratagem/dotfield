# SPDX-FileCopyrightText: (C) 2026 Chris Montgomery <chmont@protonmail.com>
#
# SPDX-License-Identifier: GPL-3.0-or-later

{
  coreutils,
  awww,
  writeShellApplication,
}:
writeShellApplication {
  name = "awww-randomize";
  runtimeInputs = [
    coreutils
    awww
  ];
  text = builtins.readFile ./script.sh;
}
