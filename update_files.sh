#!/bin/sh

files=(
	.chktexrc
	.config/fontconfig/conf.d/inactive-monospace-nolig.conf
	.config/kitty/kitty.conf
	.config/nvim/after/
	.config/nvim/my_snippets/
	.config/nvim/others/
	.config/nvim/init.vim
	.gitconfig
	.latexmkrc
	.lispwords.lua
	.ltex/
	.mpv/
	.ocamlinit
	.taskrc
	.XCompose
	.zshrc
)

for file in ${files[*]}; do
	if [ -e $file ]; then
		echo "Update  $file ..."
	else
		echo "Install $file ..."
	fi
	cp -rT ~/$file $file
done
