#!/bin/sh

files=(
	.chktexrc
	.config/fontconfig/conf.d/inactive-monospace-nolig.conf
	.config/kitty/kitty.conf
	.config/nvim/my_snippets/
	.config/nvim/others/
	.config/nvim/init.vim
	.gitconfig
	.latexmkrc
	.ltex/
	.mpv/
	.ocamlinit
	.XCompose
	.zshrc
)

for file in ${files[*]}; do
	echo "Update $file ..."
	cp -rT ~/$file $file
done
