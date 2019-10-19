#!/bin/env bash
# Copyright 2019 (c) all rights reserved by BuildAPKs see LICENSE
# buildapks.github.io/buildAPKs/ published courtesy pages.github.com/
#####################################################################
set -Eeuo pipefail
shopt -s nullglob globstar

_SMATRPERROR_() { # run on script error
	local RV="$?"
	printf "\\n%s ma.bash\\n" "$RV" 
	printf "\\e[?25h\\n\\e[1;48;5;138mBuildAPKs ma.bash %s %s ERROR:  Generated script error %s near or at line number %s by \`%s\`!\\e[0m\\n" "${0##*/}" "${PWD##*/}" "${1:-UNDEF}" "${2:-LINENO}" "${3:-BASH_COMMAND}"
	_WAKEUNLOCK_
	exit 147
}

_SMATRPEXIT_() { # run on exit
	printf "\\e[?25h\\e[0m"
	set +Eeuo pipefail 
	exit 0
}

_SMATRPSIGNAL_() { # run on signal
	local RV="$?"
	printf "\\n%s ma.bash\\n" "$RV" 
	_WAKEUNLOCK_
	printf "\\e[?25h\\e[1;7;38;5;0mBuildAPKs ma.bash %s WARNING:  Signal %s received!\\e[0m\\n" "${0##*/}" "$RV"
 	exit 148 
}

_SMATRPQuIT_() { # run on quit
	local RV="$?"
	printf "\\n%s ma.bash\\n" "$RV" 
        printf "\\e[?25h\\n\\e[1;48;5;138mBuildAPKs ma.bash %s WARNING:  Quit signal %s received near or at line number %s by \`%s\`!\\e[0m\\n" "${0##*/}" "${1:-UNDEFINED}" "${2:-LINENO}" "${3:-BASH_COMMAND}"
	_WAKEUNLOCK_
 	exit 149 
}

trap '_SMATRPERROR_ $? $LINENO $BASH_COMMAND' ERR 
trap _SMATRPEXIT_ EXIT
trap _SMATRPSIGNAL_ HUP INT TERM 
trap '_SMATRPQuIT_ $? $LINENO $BASH_COMMAND' QUIT 

cd "$JDR"
# _AT_ name/project commit

# ma.bash OEF 