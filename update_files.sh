#!/bin/sh

files=(
	.chktexrc
	.config/fontconfig/conf.d/inactive-monospace-nolig.conf
	.config/git/
	.config/kitty/
	.config/latexmk/
	.config/ltex/
	.config/mpv/
	.config/nvim/after/
	.config/nvim/my_snippets/
	.config/nvim/others/
	.config/nvim/init.vim
	.config/ocaml/
	.config/task/
	.lispwords.lua
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
