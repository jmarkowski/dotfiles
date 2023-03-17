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
