#!/bin/bash
# 
# Symlinks the configfiles
#

SCRIPT=$(readlink -f $0)
SCRIPTPATH=`dirname $SCRIPT`
cd ~
for i in .vim .vimrc .fonts .oh-my-zsh/custom .config/i3 .config/i3blocks
do
	if [ -e $i ]
	then
		backed+=$i" "
		mv "$i" "$i.bak"
	fi
	ln -s "$SCRIPTPATH/$i" "$i"
done
if [ -n "$backed" ]
then
	echo "Backed up already existing files/directories: $backed"
fi
