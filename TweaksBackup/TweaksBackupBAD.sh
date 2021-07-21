#!/bin/bash

# Script created by My-ThrowAwayAccount

red='\033[0;31m'
clear='\033[0m'

echo "This script does partly work, but should not be used in its current state, as can be implied from the word "BAD" in the file name."
echo "The issue with this script is that it blidnly copies the MobileSubstrate folder, your tweaks basically."
echo "Yes, that is the issue. Tweaks, packages in general must be installed through apt-get"
echo "And as much as this would preserve the packages/tweaks version, it wouldn\'t mark them as installed"
echo "Tweaks and packages \"installed\" this way will definitely cause issues and instability (that I have experienced myself)."
echo "Shortly, this shouldn\'t be used."
echo "Maybe a combination of this script and the other script will be created one day, to maintain package versions."
echo "In the meantime, please use the appropriate script."
printf "Again: ${red} DO NOT USE THIS SCRIPT.${clear}\n"
exit

# The principle behind this script is that most tweaks
# And I'm not talking about all packages and libraries, for example, wouldn't be backed up
# Are stored in /Library/MobileSubstrate/DynamicLibraries
# Saving those files and then putting them back apparently makes them somewhat work again.
# This would be handy to restore without connection, or restore tweaks that are no longer available
# Or yet again to restore a specific version of those tweaks.
# But since we are not really installing these packages (to properly install a package you need to apt-get them or dpkg install a deb)
# This causes many issues.

# This could maybe (?) be updated to extract debs and then install them again, but as of right now this is just a concept.

echo "1. Backup your tweaks"
echo "2. Restore your tweaks"
echo "Anything else to close out of the script."

read -p '> ' option

destination='/private/var/mobile/Documents/TweaksBackup/'
origin='/Library/MobileSubstrate/'

if [[ "$option" == 1 ]]; then
	mkdir -p $destination && cp -R "$origin"* $destination
else
	if [[ "$option" == 2 ]]; then
		cp -R "$destination"* $origin
	else
		echo "Invalid option."
	fi
fi
