#!/bin/env bash
# Copyright 2019-2021 (c) all rights reserved by BuildAPKs see LICENSE
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
_AT_ aosp-mirror/platform_packages_apps_soundrecorder 30b3ba89e435bc2d0b686cab2f2c0d5a33c8fbeb
_AT_ aosp-mirror/platform_packages_apps_music 922216b0b0a57e56663dd480f908589cb8e5159d
_AT_ aosp-mirror/platform_packages_apps_htmlviewer 0e521ae9aa2c8b1b3d30870ec9662affef4b61a7
_AT_ JohnPark86/MultiUse b2d17ca3f630ac883e9785458493b860066e46ce
_AT_ mess110/CarrotRush 0408517dd8e246286e7ba0823602a7c8788ba6fe
_AT_ SilangQuan/CoolReader f247e0dbd154ee49a8bee456931934b16fae06bd
_AT_ termux/TermuxAm 1620e7c88bb1c120afa9301a423374b43637dcf1
_AT_ vitaly-little/RRatoraktInternetRadio 0789ed433d104aece88c1ecacf21ea603d3fd9be
# ma.bash OEF
