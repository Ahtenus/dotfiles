# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000
export EDITOR=vim
# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "$debian_chroot" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

function l(){
	locate $1 | more
}
# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias du='du -h'
alias df='df -h'
alias svndiff='svn diff -x --ignore-space-change | view -'
alias apti='sudo apt-get install'
alias s='sudo'
alias log='git log --oneline'
alias h='history | grep'
alias gca='git commit -a'
alias gcam='git commit -a -m'
function cowfort(){
if [ -x /usr/games/fortune ] ; then
	RANGE=4
	number=$RANDOM
	let "number %= $RANGE"
	case $number in
		0)
			cow="duck"
			;;
		1)
			cow="tux"
			;;
		2)
			cow="koala"
			;;
		3)
			cow="moose"
			;;
	esac

	RANGE=2
	number=$RANDOM
	let "number %= $RANGE"
	case $number in
		0)
			command="/usr/games/cowsay"
			;;
		1)
			command="/usr/games/cowthink"
			;;
	esac
	if [ -x $command ] ;then 
		/usr/games/fortune | $command -f $cow
	else
		/usr/games/fortune
	fi
fi
}
function a2pslatin {
	temp=`mktemp --suffix=.${1##*/}`
	iconv -f utf-8 -t latin1 $1 -o $temp
	a2ps --encoding=latin1 -B --title=${1##*/} $temp -o ${1##*/}.ps
	ps2pdf ${1##*/}.ps ${1##*/}.pdf
}
# Add custom commands that should not be version controlled to .bash_custom
if [ -f ~/.bash_custom ]; then
    . ~/.bash_custom
fi
#cowfort
