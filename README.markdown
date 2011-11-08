A collection of some config files.

Installation
------------

	cd ~
	git clone git://github.com/Ahtenus/dotfiles.git
	cd dotfiles
	git submodule init
	git submodule update
	./link.sh

Symlink the files/folders into your home folder using the link.sh script.


Adding new plugins
------------------
	git submodule add git://url-to-plugin.git .vim/bundle/plugin-name
