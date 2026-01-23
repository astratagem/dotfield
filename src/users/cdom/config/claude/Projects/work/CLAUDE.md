This is the `~/Projects/work/` directory.  It is not a
project in itself, but rather it is a root container for a collection of
projects.

Everything under this tree pertains to development for Klein College of
Media and Communication at Temple University.

Directories whose name begins with the underscore (`_`) prefix are
generally excluded as local-only or private directory trees.  Their name
indicates an organizing principle.  For example,
`~/Projects/work/applications/_archive/` contains former web
applications that are no longer active.  Each of these organizing scopes
should be covered by the patterns listed in `~/Projects/work/.ignore`.

## General

All Git repos should:

- Use a GPL-3.0-or-later license
- Derive from the
  <[@kleinweb/configs-template](https://github.com/kleinweb/configs-template)>
  Copier template

## `applications/`

Each of the directories under this hierarchy is a Git repo containing
the source code for an individual web application (usually WordPress).

Each app should:

- Follow the same general project structure as modelled by the
  <[@kleinweb/site-template](https://github.com/kleinweb/site-template)>
  Copier template
- Follow the same coding standards and development practices
- Use a `justfile` that provides a common interface to project
  development processes

## `contrib/`

The contrib tree contains Git repos forked from projects to which I
contribute.

Each of the first-level directories under this hierarchy is the name of
an upstream username.  The second level contains individual projects
cloned locally for development.

## `fox/`

This directory contains my work related to the output of the development
team at the Fox School of Business.

## `mirrors/`

Each of the first-level directories under this hierarchy is the name of
an originating source, oftentimes a username.  The second level should
contain individual projects copied locally for reference.  They do not
need to be Git repos.

If you instead plan on contributing back to the upstream project, store
the repo in `contrib/` instead.

## `resources/`

A collection of resources for use as development helpers in an IDE.  For
example, `resources/WordPress` contains the WordPress core files for use
as a “Resource Root” in PhpStorm.

## `scratch/`

Files and directories contained within have no organizing principle.
This is the “random” bin, like `~/Downloads/`.  Its contents should be
considered ephemeral.

## `template-repos/`

This directory contains Git repos for some Copier templates.

For more information, refer to the directory-local documentation in
`./template-repos/CLAUDE.md`.
