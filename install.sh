#!/bin/bash

echo 'The "~/bin/prjsetup.sh" and "~/.vim" will be removed.'
read -p "Are you sure to setup environment for $USER(yes/no):" confirmr

if [ "$confirmr" = "yes" -o "$confirmr" = "y" -o "$confirmr" = "Y" -o "$confirmr" = "YES" ]; then
	sudo rm -rf ~/bin/prjsetup.sh
	sudo rm -rf ~/.vim

	sudo apt-get install -y exuberant-ctags cscope ckermit vim

	mkdir -p ~/bin
	cp -r bin/* ~/bin/
	cp -r vim ~/.vim
	cp kermrc ~/.kermrc

	sudo chown -R $USER: ~/bin
	sudo chown -R $USER: ~/.vim

	searchr=`grep 'export PATH=\$PATH:~/bin' ~/.bashrc`
	if [ "$searchr" = "" ]; then
		echo 'export PATH=$PATH:~/bin' >> ~/.bashrc
	fi
	sed -i 's/^function! s:handleMiddleMouse()/&\n\treturn/g' ~/.vim/plugin/NERD_tree.vim
else
	echo "The install is canceled."
fi
