# You can put files here to add functionality separated per file, which
# will be ignored by git.
# Files on the custom/ directory will be automatically loaded by the init
# script, in alphabetical order.

git-branchdiff () {
	git diff --name-only $(git merge-base HEAD $1)
}

alias xclip="xclip -selection c"

alias zshconfig="code ~/.oh-my-zsh/custom/v.zsh && source ~/.zshrc"
alias zshrc="code ~/.zshrc && source ~/.zshrc"
alias i3config="code ~/.config/i3/config"

zshplugin () {
   code "/home/v/.oh-my-zsh/custom/plugins/$1/$1.plugin.zsh" 
}


json-pretty-print () {
	for file in $2 ; do
		mkdir -p ${file:h}/formatted/
		python -m json.tool ${file} > ${file:h}/formatted/${file:t}
	done
}

alias telegram="python3 ~/telegram_api.py"

alias explore="nautilus . 2>&1 > /dev/null & ; disown"

alias gg="cowsay -d GG"

alias jmc7="/home/v/jmc/target/products/org.openjdk.jmc/linux/gtk/x86_64/jmc"