#!/bin/sh

files=(
	.chktexrc
	.config/nvim/my_snippets/
	.config/nvim/init.vim
	.gitconfig
	.latexmkrc
	.ltex/
	.mpv/
	.XCompose
	.zshrc
)

for file in ${files[*]}; do
	echo "Update $file ..."
	cp -rT ~/$file $file
done
