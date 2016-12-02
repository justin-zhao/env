#!/bin/bash

echo 'The "~/bin/prjsetup.sh" and "~/.vim" will be removed.'
read -p "Are you sure to setup environment for $USER(yes/no):" confirmr

if [ "$confirmr" != "yes" -a "$confirmr" != "y" -a "$confirmr" != "Y" -a "$confirmr" != "YES" ]; then
	echo "The install is canceled."
	exit 0
fi

#Clear old data
sudo rm -rf ~/bin/prjsetup.sh
sudo rm -rf ~/.vim

#Check distribution version
apt-get -h 2>/dev/null
distrover=$?

if [ "$distrover"x = "0"x ]; then
	sudo apt-get install -y exuberant-ctags cscope gkermit vim screen
else
	sudo yum install -y ctags cscope vim screen minicom
fi

#Config the app
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

searchr=`grep 'caption always' /etc/screenrc`
if [ "$searchr" = "" ]; then
	sudo sed -i '$acaption always "%{.bW}%-w%{.rW}%n %t%{-}%+w %=%H %Y/%m/%d "' /etc/screenrc
fi

if [ "$distrover"x != "0"x ]; then
	sed -i 's/[^"]cs add .\//"cs add .\//g' ~/.vim/vimrc
fi
sed -i 's/^function! s:handleMiddleMouse()/&\n\treturn/g' ~/.vim/plugin/NERD_tree.vim

echo "The installatio is over!" 
