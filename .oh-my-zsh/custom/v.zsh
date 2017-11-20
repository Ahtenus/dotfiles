# You can put files here to add functionality separated per file, which
# will be ignored by git.
# Files on the custom/ directory will be automatically loaded by the init
# script, in alphabetical order.

git-branchdiff () {
	git diff --name-only $(git merge-base HEAD $1)
}

alias xclip="xclip -selection c"

alias zshconfig="vim ~/.oh-my-zsh/custom/v.zsh && source ~/.zshrc"
alias zshrc="vim ~/.zshrc && source ~/.zshrc"
alias i3config="vim ~/.config/i3/config"