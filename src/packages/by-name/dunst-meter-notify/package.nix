# SPDX-FileCopyrightText: (C) 2026 Chris Montgomery <chmont@protonmail.com>
#
# SPDX-License-Identifier: GPL-3.0-or-later

{
  bc,
  brightnessctl,
  dunst,
  gawk,
  wireplumber,
  writeShellApplication,
}:
writeShellApplication {
  name = "dunst-meter-notify";
  runtimeInputs = [
    bc
    brightnessctl
    dunst
    gawk
    wireplumber
  ];
  text = builtins.readFile ./script.sh;
}
