# dotfiles

My linux environment's dotfiles.

# Installation

```bash
$ git clone https://github.com/jmarkowski/dotfiles.git ~/.dotfiles
$ cd ~/.dotfiles
$ ./bootstrap.sh
```

## Install VIM plugins

After the vim configuration files have been copied, especially
`.vim/bundle/Vundle.vim`, you can install the vundle plugins with:

```
$ vim +PluginInstall +qall
```

Alternatively, after your `.vimrc` is loaded, type `:PluginInstall`
to install the plugins.

# Nifty tools

`ag` as a faster alternative to `grep`.
`bat` as a colorized replacement for `cat`.
`fd` as a faster alternative to `find`.
`fzf` as a supplement to `find`.
`htop` as a replacement for `top`.
`jq` as a replacement for `sed` and `grep` for working with json files.
`tldr` as a supplement to man pages.
