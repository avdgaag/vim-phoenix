# vim-phoenix

This plugin helps you navigate and develop projects using the [Phoenix web
framework][phoenix]. A Phoenix project is detected by looking for a `mix.exs`
file along with `web` directory. When you edit a file in a Phoenix project, this
plugin will be activated. This sets various options and defines some commands.
It also integrates with other Vim plugins.

## Features

* Integrates with [vim-projectionist][] for navigating project files according
  to Phoenix conventions.
* Comes with extra mappings for [vim-surround][].
* Comes with extra snippets for [UltiSnips][].
* Provides `:Mix` command that delegates to `mix`.
* Provides project-specific Vim navigation settings for `path` and
  `suffixesadd`.

See the documentation (`:help phoenix`) for more information.

## Installation

Use your favourite Vim plugin manager to install this plugin. I use
[pathogen][]. Otherwise, download this plugin and put the files in its
subdirectories to the corresponding subdirectories in your `~/.vim` directory.

## About

To find our more about the Phoenix framework, see:
https://github.com/phoenixframework/phoenix

To get the latest updates or report bugs, see this plugin's Github repository:
https://github.com/avdgaag/vim-phoenix

## Credits

Author: Arjan van der Gaag
URL: http://arjanvandergaag.nl

This plugin is based on earlier work by Tim Pope, who has released many
incredible Vim plugins.

## License

See LICENSE.

[vim-projectionist]: https://github.com/tpope/vim-projectionist
[vim-surround]:      https://github.com/tpope/vim-surround
[UltiSnips]:         https://github.com/SirVer/UltiSnips
[pathogen]:          https://github.com/tpope/vim-pathogen
[phoenix]:           https://github.com/phoenixframework/phoenix
