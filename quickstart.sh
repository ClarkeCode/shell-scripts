#!/bin/bash

#Script to mass install packages for Raspbian

PKMANAGER="apt"
DO_INSTALL="install -y"
DO_REMOVAL="remove -y"
DESIRED=(
	"neovim" #Text editor
	"ranger" #Filesystem navigation
	"graphviz" #Flowchart diagram tools
	"texlive"  #LaTeX text formatting engine
	"texlive-latex-extra" #Additional add-ons for LaTeX
	"w3m"      #TUI web browser

	"transmission-cli"    #Filesharing
	"transmission-daemon" #

	#Fun or joke commands
	"cowsay"
	"fortune-mod"
	"cmatrix"
	"hollywood"
)

COMMAND="${1,,}"


function show-usage() {
	echo "Usage: $0 command"
	echo ""
	echo "Commands:"
	printf "\t%-8s %s\n" "install" "Automatically install desired packages"
	printf "\t%-8s %s\n" "remove"  "Automatically remove desired packages"
	printf "\t%-8s %s\n" "list"    "List all desired packages"
	printf "\t%-8s %s\n" "show"    "Preview the result of the 'install' command"
	printf "\t%-8s %s\n" "help"    "Show this message"
}


if [[ "$COMMAND" == "install" ]]; then
	$PKMANAGER $DO_INSTALL "${DESIRED[@]}"

elif [[ "$COMMAND" == "remove" ]]; then
	$PKMANAGER $DO_REMOVAL "${DESIRED[@]}"

elif [[ "$COMMAND" == "list" ]]; then
	for pkg in "${DESIRED[@]}"; do
		echo $pkg
	done
elif [[ "$COMMAND" == "show" ]]; then
	echo "$PKMANAGER" "${DESIRED[@]}"
else
	show-usage
fi
