alias rtc-wait='tools/util/wait_global_status_active.py'

rtc-start-wait () {
	if [ "${PWD##*/}" = "jpxrisk" ]; then
		bash ./start_and_create_db_au.sh
		echo "\nWaiting for system start...\n"
		rtc-wait
	fi
	if [ "${PWD##*/}" = "rtc" ]; then
		bash ./start_and_create_db_au.sh
		echo "\nWaiting for system start...\n"
		rtc-wait
	fi
	if [ "${PWD##*/}" = "jpx" ]; then
		bash ./jpx_monitor_start_create.sh
	fi
}

alias rtc-s=' ./stop.sh && rtc-list-processes'
alias rtc-s!=' ./stop.sh && ./killOrphanProcess.sh'

rtc-location () {
	if [ "${PWD##*/}" = "jpxrisk" ]; then
		echo "jpr"
    else
        echo "${PWD##*/}"
	fi
}

rtc-list-processes () {
   jcmd -l | grep 'JPXR'
   true
}
alias rtc-a='gradle ass cDE bDE --parallel -x ui:ui-$(rtc-location)-client:assemble && rtc-start-wait' 
alias rtc-ap='gradle ass cDE bDE --parallel -x ui:ui-$(rtc-location)-client:assemble applyJpxrDb && rtc-start-wait' 
alias rtc-ra='gradle ass cDE bDE idea --refresh-dependencies --parallel -x ui:ui-$(rtc-location)-client:assemble && rtc-start-wait'

alias rtc-test='gradle test -x ui:ui-$(rtc-location)-client:assemble'

alias rtc-b='gradle build cDE bDE -x ui:ui-$(rtc-location)-client:assemble && ./start_and_create_db_au.sh'
alias rtc-rb='gradle build cDE bDE --refresh-dependencies && rtc-start-wait'

alias rtc-ci='gradle build -x ui:ui-$(rtc-location)-client:assemble'

alias rtc-scb='rtc-s && rtc-cb' 
alias rtc-cb='gradle clean build cDE bDE --refresh-dependencies && rtc-start-wait'
alias rtc-ca='gradle clean ass cDE bDE --refresh-dependencies && rtc-start-wait'
alias rtc-cbi='rtc-s && rtc-cb && gradle iT'

alias rtc-sa='rtc-s && rtc-a'
alias rtc-sra='rtc-s && rtc-ra'
alias rtc-sap='rtc-s && rtc-ap'
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
	lnav $(ls -t environments/developer/deployment/system/$1/log/console/*.log | head -1)
else
	$2 $3 $4 $5 $6 $7 $8 $(ls -t environments/developer/deployment/system/$1/log/console/*.log | head -1)
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

alias rtc-list='find ./environments/developer/deployment/system/ -type d -name "log" -exec dirname {} \; | sed "s:.*/::" | sort'


rtc-gradle () {
	if [ "$PWD" = "$jpx" ]; then
		sdk u gradle 2.13
	fi
	if [ "$PWD" = "$rtc" ]; then
		sdk u gradle 3.0
	fi
	if [ "$PWD" = "$jpr" ]; then
		sdk u gradle 3.0
	fi
	if [ "$PWD" = "$rtcp" ]; then
		sdk u gradle 2.13
	fi
}

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
compdef rtc-restart=rtc-log