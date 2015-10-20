#!/bin/bash
alias con="tail -40 -f /var/log/system.log"

export EDITOR="nano"
export CLICOLOR=1
# color docs: http://osxdaily.com/2012/02/21/add-color-to-the-terminal-in-mac-os-x/
export LSCOLORS=gxcxcxdxfxexexFxFxGxGx
export XCODE=$(xcode-select --print-path)

export HOMEBREW_GITHUB_API_TOKEN=deb21da4ac7d4dad48a18dad00cd14edb1066c3a


setPath() {
	local _XCODETOOLS="$XCODE/Tools"
	local _SWIPROLOG="/Applications/SWI-Prolog.app/Contents/swipl/bin/x86_64-darwin14.3.0"
	local _HOMEBREW="/opt/local/bin:/opt/local/sbin"

	export PATH="$PATH:/Users/james/bin:$_XCODETOOLS:$_HOMEBREW:$_SWIPROLOG:"
}
setPath


# PUT THESE IN AN EARLIER STARTUP SCRIPT?

# Load in the git branch prompt script.
source ~/.git-prompt.sh

# Load in color defs
source ~/.bash_color_defs.bash

# Set the prompt \[$White\]\u
SPACE='\[\033[m\]'
PS1="\[$White\]\h:\[$Yellow\]\w\[$Purple\]\$(__git_ps1) \[$Color_Off\]\u\$ "

# Allow text selection in QuickLook
defaults write com.apple.finder QLEnableTextSelection -bool TRUE

la () {
	pwd;ls -alhF $1;pwd
}

cdla () {
	cd $1;la
}

sublime () {
	open -a "Sublime Text 2" $1
}

allFilenamesToLowercase () {
	for f in *; do mv "$f" "`echo $f | tr "[:upper:]" "[:lower:]"`"; done
}

allFilenamesDashesForBlanks () {
	for f in *; do mv "$f" "`echo $f | tr "[:blank:]" "-"`"; done
}

allFileNamesRemoveDimensions () {
	for f in *; do mv "$f" "`echo $f | sed 's/-[0-9]*x[0-9]*//'`"; done
}

normalizeImageFilenames () {
	allFilenamesToLowercase; allFilenamesDashesForBlanks; allFileNamesRemoveDimensions
}

allFilesDo () {
    for f in *; do $1 "$f"; done
}

colors() {
	local fgc bgc vals seq0

	printf "Color escapes are %s\n" '\e[${value};...;${value}m'
	printf "Values 30..37 are \e[33mforeground colors\e[m\n"
	printf "Values 40..47 are \e[43mbackground colors\e[m\n"
	printf "Value  1 gives a  \e[1mbold-faced look\e[m\n\n"

	# foreground colors
	for fgc in {30..37}; do
		# background colors
		for bgc in {40..47}; do
			fgc=${fgc#37} # white
			bgc=${bgc#40} # black

			vals="${fgc:+$fgc;}${bgc}"
			vals=${vals%%;}

			seq0="${vals:+\e[${vals}m}"
			printf "  %-9s" "${seq0:-(default)}"
			printf " ${seq0}TEXT\e[m"
			printf " \e[${vals:+${vals+$vals;}}1mBOLD\e[m"
		done
		echo; echo
	done
}


cloc() {
    perl ~/bin/cloc.pl .
}
