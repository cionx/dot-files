#!/bin/sh

files=(
	.chktexrc
	.config/nvim/my_snippets/
	.gitconfig
	.latexmkrc
	.ltex/
	.mpv/
	.vimrc
	.XCompose
	.zshrc
)

for file in ${files[*]}; do
	echo "Update $file ..."
	cp -rT ~/$file $file
done
