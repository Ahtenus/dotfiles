A collection of some config files.

Installation
------------

	cd ~
	git clone git://github.com/Ahtenus/dotfiles.git
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
