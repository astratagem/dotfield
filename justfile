# SPDX-FileCopyrightText: 2022-2026 Chris Montgomery <chmont@protonmail.com>
# SPDX-License-Identifier: GPL-3.0-or-later

###: https://just.systems/man/en/

import "./.config/common.vars.just"

mod disko ".config/disko"
mod iso ".config/iso"
mod nixify ".config/nixify.just"
mod packages "src/packages"
mod reuse ".config/reuse"
mod secrets
mod stow ".config/stow.just"
mod symlink ".config/symlink.just"
mod theme ".config/theme.just"

alias dark := theme::dark
alias light := theme::light

default:
  @just --choose

push *ARGS="-b main":
  for remote in origin github; do \
    jj git push {{ ARGS }} --remote $remote; \
  done

[doc("Run flake checks")]
check *ARGS:
  nix flake check --verbose {{ ARGS }}

[doc("Inspect flake outputs")]
inspect:
  nix-inspect

[doc("Lint the project files")]
lint:
  pre-commit run -a

[doc("Write linter fixes to project files")]
fix: (_deadnix "--edit")
    statix fix

[doc("Format the project files")]
fmt *FILES:
    treefmt {{ FILES }}

_deadnix method='--fail' *ARGS='--no-underscore':
  fd -t f -e nix --exclude='packages/**/*.nix' --exec-batch \
    deadnix {{method}} {{ARGS}}
  fd -t f -e nix . packages --exec-batch \
    deadnix {{method}} --no-lambda-pattern-names {{ARGS}}

ironbar-dev:
    watchexec -w {{ ironbar-dir }} -- 'systemctl --user restart ironbar'
