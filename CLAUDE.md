# Dotfield - NixOS Configuration

## Overview

Dotfield is a comprehensive NixOS configuration system ("dotfiles") using Nix
flakes for managing multiple machines and users. It's built around a modular
architecture with features, hosts, and users as the primary organizational
units.

## Project Structure

```text
/etc/nixos/
├── flake.nix              # Main flake definition with inputs and outputs
├── hive.nix               # Colmena deployment configuration
├── src/                   # Main source code
│   ├── features/          # Modular feature configurations
│   ├── hosts/             # Host-specific configurations
│   ├── lib/               # Custom Nix library functions
│   ├── meta/              # Metadata and constants
│   ├── modules/           # Custom NixOS/Home Manager modules
│   ├── packages/          # Custom package definitions
│   └── users/             # User-specific configurations
├── dev/                   # Development environment tools
├── tests/                 # Test configurations
├── secrets/               # SOPS-encrypted secrets
├── overlays/              # Nix package overlays
└── npins/                 # Pinned dependencies
```

## Key Technologies & Dependencies

- **Nix Flakes**: Modern Nix configuration management
- **flake-parts**: Modular flake structure framework
- **Home Manager**: User environment management
- **SOPS**: Secret management with age/PGP encryption
- **Colmena**: Remote deployment tool for NixOS
- **Stylix**: System-wide theming based on base16
- **Git Hooks**: Pre-commit hooks for code quality

## Build Commands

The project uses `just` as a command runner. Key commands:

```bash
# System management
just build [ARGS]          # Build system configuration
just boot [ARGS]           # Build and set for next boot
just switch [ARGS]         # Build and switch to new generation
just home [ARGS]           # Manage home-manager configurations

# Development
just check [ARGS]          # Run flake checks
just lint                  # Run linters
just fix                   # Auto-fix linting issues
just fmt                   # Format code

# Theme management
just theme [kind]          # Switch system theme (light/dark)
just light                 # Switch to light theme
just dark                  # Switch to dark theme
```

## Architecture

### Aspects System

Features are organized using an "aspects" pattern that separates NixOS and
Home Manager configurations:

```nix
# Example feature structure (src/features/theme.nix)
{
  aspects.graphical.nixos = { pkgs, ... }: {
    # NixOS-level configuration
    stylix.enable = true;
  };

  aspects.graphical.home = { config, pkgs, ... }: {
    # Home Manager configuration (applied per-user)
  };
}
```

Key patterns:

- `aspects.<name>.nixos` - NixOS module configuration
- `aspects.<name>.home` - Home Manager module configuration
- Aspects can declare dependencies via a `requires` attribute
- Host configurations reference aspects by name in their `aspects` list

The module at `src/modules/flake/nixos.nix` assembles hosts by:
1. Collecting NixOS modules from all host aspects
2. Creating Home Manager configurations per-user from their aspects
3. Applying overlays and baseline configurations

### Features System

The `src/features/` directory contains modular configurations that can be
enabled per host or user:

- Core system features (boot, networking, audio)
- Development tools (git, direnv, editors)
- Desktop environments (GNOME, Sway)
- Applications and services

### Host Configuration

Each host in `src/hosts/` defines:

- Hardware-specific settings
- Enabled features and modules
- User assignments
- Deployment metadata

### User Management

User configurations in `src/users/` provide:

- Home Manager configurations
- User-specific feature sets
- Application preferences
- Development environments

### Theme Specialisations

Theme switching uses NixOS and Home Manager specialisations to provide
pre-built dark/light variants:

**NixOS Specialisations** (`src/features/theme.nix`):
- System-level theme variants at `/run/current-system/specialisation/{dark,light}/`
- Controls GTK, Qt, and system-wide Stylix theming

**Home Manager Specialisations** (`src/users/*/features/theme.nix`):
- User-level variants at `~/.local/state/nix/profiles/home-manager/specialisation/{dark,light}/`
- Controls application-specific theming (Firefox, VS Code, cursor themes)

**Switching themes:**
```bash
just dark   # or: just theme dark
just light  # or: just theme light
```

The `just theme` command uses `nh home switch -s {kind}` to activate the
Home Manager specialisation, plus additional commands for applications that
need runtime updates (Emacs, kitty, GTK).

## Current Hosts

- **tuvok**: MacBook Air M2 running NixOS via Asahi Linux (daily driver)
- **ryosuke**: Teenage Engineering Computer-1 mini-ITX desktop (HTPC/office)
- **boschic**: Gaming/workstation desktop with RTX 3080 Ti
- **hodgepodge**: Early-2014 MacBook Pro (retirement/testing)

## Development Environment

The project includes comprehensive development tooling:

- Pre-commit hooks for Nix linting and formatting
- Treefmt for consistent code formatting
- Statix for Nix static analysis
- Deadnix for unused code detection
- Git hooks for commit message validation

## Secret Management

Secrets are managed using SOPS with age encryption:

- Public keys stored in `ops/keys/`
- Encrypted secrets in `secrets/`
- Automatic key management via `.sops.yaml`

## Package Management

Custom packages are defined in `src/packages/` and overlays in `overlays/`.
The configuration supports:

- Package overrides and patches
- Custom derivations
- Binary cache integration (Cachix)

## Testing

The `tests/` directory contains:

- NixOS VM tests
- Feature integration tests
- CI/CD validation

This configuration emphasizes modularity, reproducibility, and maintainability
while providing a rich desktop and development environment across multiple
machines.
