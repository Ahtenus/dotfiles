A collection of some config files.

Installation
============
Simple installation

    curl https://raw.github.com/Ahtenus/dotfiles/master/install | bash

or

    wget -q0- https://raw.github.com/Ahtenus/dotfiles/master/install | bash

This above command is equivalent to

	cd ~
	git clone https://github.com/Ahtenus/dotfiles.git
	cd dotfiles
	git submodule init
	git submodule update
	./link.sh

Adding new Vim plugins
----------------------
	git submodule add git://url-to-plugin.git .vim/bundle/plugin-name
	git submodule init
	git submodule update
	vim -c 'call pathogen#helptags()|q'
