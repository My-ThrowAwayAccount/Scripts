#!/bin/bash

# Script created by My-ThrowAwayAccount

green='\033[1;32m'
yellow='\033[1;33m'
clear='\033[0m'
red='\033[0;31m'

printf "${green}Welcome to ${yellow}TweaksBackup${clear}!\n"
printf "This script can be used to, you guessed it, back up your tweaks! (well, packages)\n"
printf "${red}Warning! Please read below with caution.${clear}\n"
printf "This script is ${red}NOT${clear} capable of backing up your packages/tweaks data.\n"
printf "I am ${red}not${clear} responsable for any damaged that may be caused to your system.\n"
printf "Blindly installing every package listed in an accessible and non-encrypted text file is ${red}not a good idea${clear}.\n"
printf "${red}You should check every package before installing them.${clear}\n"
printf "This script, as of right now, does ${red}NOT${clear} back up the packages version or the repository they come from.\n"
printf "That being said, type ${green}1${clear} if you are fine with running this script, anything else if you want to close it.\n"

read -p '> ' agreement
if [[ "$agreement" != 1 ]]; then
	exit
fi

echo "1. Backup your tweaks"
echo "2. Restore your tweaks"
echo "Anything else to close out of the script."

read -p '> ' option

backup='/private/var/mobile/Documents/TweaksBackup.txt'

if [[ "$option" == 1 ]]; then
	rm "$destination" 2> /dev/null
	dpkg -l | grep -v '^rc\|gsc\|cy+' | cut -d ' ' -f 3 | sed 1,5d > "$backup" # https://www.reddit.com/comments/3xuiuk/1/cy7z2qs
	echo "Your file has been saved at the location $backup (inside of your Documents folder)"
else
	# We need gawk to use the "awk" command
	if [ $(dpkg-query -W -f='${Status}' gawk 2>/dev/null | grep -c "ok installed") -eq 0 ];
	then
		echo "gawk is not installed on this machine. Proceeding to install."
		apt-get install gawk;
	fi
	if [[ "$option" == 2 ]]; then
		xargs -a <(awk '! /^ *(#|$)/' "$backup") -r -- apt-get install
		# apt-get install $(grep -vE "^\s*#" "$backup"  | tr "\n" " ")
	else
		echo "Invalid option."
	fi
fi
