#!/bin/bash

function join { local IFS="$1"; shift; echo "$*"; }

# Import Key For 1Password
#curl -sS https://downloads.1password.com/linux/keys/1password.asc | gpg --import

pacman_packages=( brave-browser yay nautilus-terminal )
aur_packages=( 1password )
snap_packages=(  )
flatpak_packages=(  )
logfile=step-2.log
username=""

###########################################################
### Alternative ###
#pacman_string=$(join " " ${pacman_packages[@]})
#echo $pacman_string
#pacman -S --needed --no-confirm $pacman_string
###########################################################

# Welcome
echo "##########################################"
echo "########  Manjaro Post Installer #########"
echo "##########################################"
echo ""
echo -n "Please Enter your Username: ";
read;
username=${REPLY}
echo "Hi $username"
echo ""

### Install all Pacman Packages ###
echo "### Installing Pacman Packages ###"
for package in "${pacman_packages[@]}"				  
do	
	echo -n "Installing $package "
	sudo pacman -S --noconfirm --needed $package &>> $logfile
	echo "[OK]"
done


### Installing all AUR Packages ###
mkdir -p tmpaur/
cd tmpaur/
echo "### Installing AUR Packages ###"
for package in "${aur_packages[@]}"				  
do
	echo -n "Installing $package "
	sudo -u $username yay -S --noconfirm --needed $package &>> $logfile
	echo "[OK]"
done
echo ""
cd ..
rm -rf tmpaur

### Installing all Snap Packages ###
echo "### Installing SNAP Packages ###"
for package in "${snap_packages[@]}"				  
do
	echo -n "Installing $package "
	snap install $package &>> $logfile
	echo "[OK]"
done


### Installing all Flatpak Packages ###
echo "### Installing Flatpak Packages ###"
for package in "${flatpak_packages[@]}"				  
do
	echo -n "Installing $package "
	flatpak install $package &>> $logfile
	echo "[OK]"
done

echo "ALL DONE"
echo "Now continue with Step 3"
