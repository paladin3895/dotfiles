#!/bin/sh
cp ~/.zshrc ./zsh/
cp ~/.aliases ./zsh/
cp ~/.utilities ./zsh/

cp ~/.config/nvim/init.vim ./nvim/
cp ~/.vimrc ./vim/

cp ~/.tmux.conf ./tmux/.tmux.conf

cp ~/.config/ranger/rc.conf ./ranger/
cp ~/.config/ranger/rifle.conf ./ranger/
cp ~/.config/ranger/commands.py ./ranger/

cp ~/.semicolon/main.sh ./semicolon/main.sh
cp ~/.semicolon/package.json ./semicolon/package.json
cp -r ~/.semicolon/utils ./semicolon/utils
