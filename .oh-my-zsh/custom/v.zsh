# You can put files here to add functionality separated per file, which
# will be ignored by git.
# Files on the custom/ directory will be automatically loaded by the init
# script, in alphabetical order.

alias rtc-wait='tools/util/wait_global_status_active.py'

rtc-start-wait () {
	if [ "$PWD" = "$jpr" ]; then
		bash ./start_and_create_db_au.sh
		echo "\nWaiting for system start...\n"
		rtc-wait
	fi
	if [ "$PWD" = "$rtc" ]; then
		bash ./start_and_create_db_au.sh
		echo "\nWaiting for system start...\n"
		rtc-wait
	fi
	if [ "$PWD" = "$jpx" ]; then
		bash ./jpx_monitor_start_create.sh
	fi
}


alias rtc-s=' ./stop.sh'
alias rtc-s!=' ./stop.sh && ./killOrphanProcess.sh'

rtc-location () {
	if [ "$PWD" = "$jpr" ]; then
		echo "jpr"
	fi
	if [ "$PWD" = "$rtc" ]; then
		echo "rtc"
	fi
	if [ "$PWD" = "$jpx" ]; then
		echo "jpx"
	fi
}
alias rtc-a='gradle ass cDE bDE --parallel -x ui:ui-$(rtc-location)-client:assemble && rtc-start-wait' 
alias rtc-ra='gradle ass cDE bDE idea --refresh-dependencies --parallel -x ui:ui-$(rtc-location)-client:assemble && rtc-start-wait'

alias rtc-test='gradle test -x ui:ui-$(rtc-location)-client:assemble'

alias rtc-b='gradle build cDE bDE -x ui:ui-$(rtc-location)-client:assemble && ./start_and_create_db_au.sh'
alias rtc-rb='gradle build cDE bDE --refresh-dependencies && rtc-start-wait'

alias rtc-scb='rtc-s && rtc-cb' 
alias rtc-cb='gradle clean build cDE bDE --refresh-dependencies && rtc-start-wait'
alias rtc-ca='gradle clean ass cDE bDE --refresh-dependencies && rtc-start-wait'
alias rtc-cbi='rtc-s && rtc-cb && gradle iT'

alias rtc-sa='rtc-s && rtc-a'
alias rtc-sra='rtc-s && rtc-ra'
alias rtc-sb='rtc-s && rtc-b'
alias rtc-srb='rtc-s && rtc-rb'

alias rtc-ai='rtc-a && gradle iT'
alias rtc-rai='rtc-ra && gradle iT'
alias rtc-bi='rtc-b && gradle iT'
alias rtc-rbi='rtc-rb && gradle iT'

alias rtc-sai='rtc-s && rtc-ai'
alias rtc-srai='rtc-s && rtc-rai'
alias rtc-sbi='rtc-s && rtc-bi'
alias rtc-srbi='rtc-s && rtc-rbi'


rtc-stop () {
	environments/developer/deployment/system/cmd/stop_server.sh $1
}
rtc-start () {
	environments/developer/deployment/system/cmd/start_server.sh $1
}

rtc-restart () {
	rtc-stop $1
	rtc-start $1
}


alias rtc-cache-test='rm -R ~/test-results-cache/tests ; mv rtc-test/rtc-system-test/build/reports/tests/ ~/test-results-cache/ && cygstart ~/test-results-cache/tests/index.html'
alias rtc-cleandb='rtc-s && ./cleandb.sh && ./start_and_create_db_au.sh'

alias rtc-status='python3 ~/scripts/rtc-p.py'

alias rtc-uicdeploy='npm run build:lib && cp -r lib $jprc/node_modules/rtc && cp -r src $jprc/node_modules/rtc'

rtc-log () {
if [ -z "$2" ]; then
	lnav "environments/developer/deployment/system/$1/log/console/$1-stderr.log"
else
	$2 $3 $4 $5 $6 $7 $8 "environments/developer/deployment/system/$1/log/console/$1-stderr.log"
fi
}

rtc-logl () {
if [ -z "$2" ]; then
	lnav environments/developer/deployment/system/$1/log/console/*(om[1])
else
	$2 $3 $4 $5 $6 $7 $8 environments/developer/deployment/system/$1/log/console/*(om[1])
fi
}

rtc-logc () {
	while true
   	do
	   	clear 
		rtc-log $1
		sleep 1
   	done
}
git-branchdiff () {
git diff --name-only $(git merge-base HEAD $1)
}

alias rtc-list='find ./environments/developer/deployment/system/ -type d -name "log" -exec dirname {} \; | sed "s:.*/::" | sort'


jpr=/home/v/projects/jpxrisk
jprc=~/projects/jpxrisk/ui/ui-jpr-client/
rtc=/home/v/projects/rtc
jpx=/home/v/projects/jpx
jpxc=~/projects/jpx/ui/ui-jpx-client/
rmsp=~/projects/rms-protocol/
uic=~/projects/rtc-ui-client-components/
rtcp=~/projects/rtc-plugin/


rtc-gradle () {
	if [ "$PWD" = "$jpx" ]; then
		sdk u gradle 2.13
	fi
	if [ "$PWD" = "$rtc" ]; then
	#	sdk u gradle 2.13
		sdk u gradle 3.0
	fi
	if [ "$PWD" = "$jpr" ]; then
		sdk u gradle 3.0
	fi
	if [ "$PWD" = "$rtcp" ]; then
		sdk u gradle 2.13
	fi
}

alias xclip="xclip -selection c"

alias zshconfig="vim ~/.oh-my-zsh/custom/v.zsh && source ~/.zshrc"
alias zshrc="vim ~/.zshrc && source ~/.zshrc"
alias i3config="vim ~/.config/i3/config && source ~/.zshrc"
# bindkey "${terminfo[khome]}" beginning-of-line
# bindkey "${terminfo[kend]}" end-of-line

if [[ $PWD = "/home/v" ]]; then 
	cd $jpr
fi

## COMPLETIONS

_rtc-completion() { 
    local curcontext="$curcontext" state line
    typeset -A opt_args
 
	SERVERS=`find ./environments/developer/deployment/system/ -type d -name "log" -exec dirname {} \; | sed "s:.*/::" | tr "\n" " "`
	_arguments '1:Server:('$SERVERS')'
}


compdef _rtc-completion rtc-log
compdef rtc-logl=rtc-log
compdef rtc-stop=rtc-log
compdef rtc-start=rtc-log
