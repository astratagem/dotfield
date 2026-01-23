# Work: Template Repos (`~/Projects/work/template-repos/`)

**This file is scope-specific documentation included by
`~/Projects/work/CLAUDE.md`.**  Refer to that file for full context.

This directory contains Git repos for some Copier templates.

When downstream projects make generally-useful improvements to files
derived from a template, these changes should be propagated back to an
appropriate template repo.

## `configs-template/`

Copier template containing generic configuration files used by all of our repos.

Generally, use-case-specific templates (e.g. `site-template`,
`plugin-template`) should derive from the `configs-template`.
Note that `configs-template` also derives from itself!

## `plugin-template/`

Copier template for a standalone WordPress plugin.

Derived from `configs-template`.

## `site-template/`

Copier template for a WordPress application.

This is the most substantial of the templates and tends to be updated
most frequently.

Derived from `configs-template`.
