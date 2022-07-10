#!/bin/bash

install_flatpaks=0
install_snaps=0
install_tlp=0

pacman_pak_str=""
aur_pak_str=""
snap_pak_str=""
flatpak_pak_str=""

##################################
############ Settings ############
##################################
logfile=step-2.log

######## Pacman Packages #########
# Brave Browser
pacman_pak_str+="brave-browser "

# Windows Dual Boot Preconditions
pacman_pak_str+="os-prober dosfstools ntfs-3g gvfs "

# Torrent Downloader
pacman_pak_str+="qbittorrent "

# Battery Manager
if [ $install_tlp == 1 ]
then
	pacman_pak_str+="tlp tlp-rdw "
fi

# For Proton Mail Bridge
pacman_pak_str+="gnome-keyring "

# Email Client
pacman_pak_str+="evolution "

# Media Player
pacman_pak_str+="vlc "

### Comment TODO ###

# Video Recording
pacman_pak_str+="obs-studio "

# AUR Package Manager
pacman_pak_str+="yay "

# Fonts
pacman_pak_str+="ttf-dejavu ttf-liberation adobe-source-sans-pro-fonts ttf-droid ttf-ubuntu-font-family ttf-anonymous-pro ttf-bitstream-vera cantarell-fonts ttf-fira-code noto-fonts noto-fonts-extra noto-fonts-emoji noto-fonts-cjk ttf-roboto ttf-font-awesome ttf-roboto-mono "

# Language Support ( Spell, ...)
pacman_pak_str+="aspell aspell-de aspell-en hyphen hyphen-de hyphen-en hunspell-de hunspell-en_us mythes-en mythes-de languagetool libmythes "

# Video Converter
pacman_pak_str+="handbrake "

# Burning
pacman_pak_str+="brasero "

# MISC
pacman_pak_str+="gimp gimp-help-de darktable "
pacman_pak_str+="neofetch "
pacman_pak_str+="calibre "
pacman_pak_str+="gnome-builder "
pacman_pak_str+="ipython "
pacman_pak_str+="bleachbit "
pacman_pak_str+="libreoffice-still libreoffice-still-de "
pacman_pak_str+="ghidra "
pacman_pak_str+="tree "
pacman_pak_str+="telegram-desktop "
pacman_pak_str+="gnome-games lutris "
pacman_pak_str+="dia ghex "
pacman_pak_str+="speech-dispatcher "
pacman_pak_str+="unarchiver most system-config-printer "
pacman_pak_str+="steam-manjaro "
pacman_pak_str+="glances "
pacman_pak_str+="virtualbox "
pacman_pak_str+="python-virtualenv "
pacman_pak_str+="filelight baobab "

######### AUR Packages ###########
# Arch Images
aur_pak_str+="archlinux-artwork arch-logo-dark-wallpapers arch-linux-2d-wallpapers "

# Password Manager
aur_pak_str+="1password "

# Download Manager
aur_pak_str+="jdownloader2 "

# Mail Bridge
aur_pak_str+="protonmail-bridge-bin "

# Music Manipulation
aur_pak_str+="audacium "

# MISC
aur_pak_str+="guitar-pro "
aur_pak_str+="bootstrap-studio "
aur_pak_str+="github-desktop-bin "
aur_pak_str+="gitkraken "
aur_pak_str+="zotero-bin "
aur_pak_str+="virtualbox-ext-oracle "
#aur_pak_str+="preload "
aur_pak_str+="itch-bin "
aur_pak_str+="stacer-bin "
aur_pak_str+="edb-debugger-git ida-free maltego "
aur_pak_str+="rambox-bin "
aur_pak_str+="synology-drive synology-note-station "
#aur_pak_str+="nvidia-system-monitor-git "

# Fonts
aur_pak_str+="ttf-ms-fonts ttf-hackgen ttf-mac-fonts ttf-nerd-fonts-hack-complete-git ttf-gentium-basic "

aur_pak_str+="brother-dcpj315w "
aur_pak_str+="yed "
aur_pak_str+="zoom "
aur_pak_str+="minecraft-launcher multimc-bin "
aur_pak_str+="burpsuite nmap wireshark-qt hashcat "

######### SNAP Packages ##########
snap_pak_str+=""

######## Flatpak Packages ########
flatpak_pak_str+=""
#######################################
########## MAIN SCRIPT ################
#######################################

function join { local IFS="$1"; shift; echo "$*"; }

# Import Key For 1Password
curl -sS https://downloads.1password.com/linux/keys/1password.asc | gpg --import

## Import Key For Spotify
#curl -sS https://download.spotify.com/debian/pubkey_5E3C45D7B312C643.gpg | gpg --import -

# Set NumKey Enabled
#gsettings set org.gnome.desktop.peripherals.keyboard numlock-state true

pacman_packages=( $pacman_pak_str )
aur_packages=( $aur_pak_str )
snap_packages=($snap_pak_str)
flatpak_packages=($flatpak_pak_str)

logfile=step-2.log


for package in "${aur_packages[@]}"
do
	echo $package
done

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

mhwd-kernel -li | grep linux 
echo -n "Type the Number above after Linux (e.g. linux515 -> 515)"
read;
kernel_id=${REPLY}
echo ""
echo -n "Installing virtualbox-host-modules "
pacman -S linux$kernel_id-virtualbox-host-modules &>> $logfile
echo "[OK]"

# Prepare Graphe Plugin for IDA-free
echo -n "Installing qwingraph_qt5 "
git clone https://github.com/WqyJh/qwingraph_qt5.git &>> $logfile
cd qwingraph_qt5
sudo ./install.sh &>> $logfile
cd ..
rm -rf qwingraph_qt5
echo "[OK]"

# Prepare Ghidra
echo -n "Preparing Ghidra "
mkdir -p ~/.local/share/ghidra
cp ../resources/ghidra/GHIDRA.svg ~/.local/share/ghidra/
cp ../resources/ghidra/ghidra.desktop ~/.local/share/applications/
chown $USER ~/.local/share/ghidra/GHIDRA.svg
chown $USER ~/.local/share/applications/ghidra.desktop
sudo chgrp users ~/.local/share/ghidra/GHIDRA.svg
sudo chgrp users ~/.local/share/applications/ghidra.desktop
chmod 644 ~/.local/share/ghidra/GHIDRA.svg
chmod 744 ~/.local/share/applications/ghidra.desktop
echo "[OK]"

### Install all Pacman Packages ###
echo "### Installing Pacman Packages ###"
for package in "${pacman_packages[@]}"				  
do	
	echo -n "Installing $package "
	sudo pacman -S --noconfirm --needed $package &>> $logfile

	x=`pacman -Qi $package`
	if [ -n "$x" ]
		echo "[OK]"
	else
		echo "[FAILED]"
		echo "$package FAILED!" &>> $logfile
	fi
	
done


### Installing all AUR Packages ###
mkdir -p tmpaur/
cd tmpaur/
echo "### Installing AUR Packages ###"
for package in "${aur_packages[@]}"				  
do
	echo -n "Installing $package "
	sudo -u $username yay -S --noconfirm --needed $package &>> $logfile
	x=`pacman -Qi $package`
	if [ -n "$x" ]
		echo "[OK]"
	else
		echo "[FAILED]"
		echo "$package FAILED!" &>> $logfile
	fi
done
echo ""
cd ..
rm -rf tmpaur

if [ $install_snaps == 1 ]
then
	### Installing all Snap Packages ###
	echo "### Installing SNAP Packages ###"
	for package in "${snap_packages[@]}"				  
	do
		echo -n "Installing $package "
		snap install $package &>> $logfile
		echo "[OK]"
	done
else
	echo "SKIPPING SNAPS"
	sleep 3
fi


### Installing all Flatpak Packages ###
if [ $install_flatpaks == 1 ]
then
	echo "### Installing Flatpak Packages ###"
	for package in "${flatpak_packages[@]}"				  
	do
		echo -n "Installing $package "
		flatpak -y install $package &>> $logfile
		echo "[OK]"
	done
else
	echo "SKIPPING FLATPAK"
	sleep 3
fi

### PAMAC ###
#echo -n "Installing flat-remix-gnome "
#pamac install --no-confirm flat-remix-gnome &>> $logfile
#echo "[OK]"
echo "### Installing PAMAC-Mode Packages"
echo -n "Installing flat-remix-gnome "
pamac install --no-confirm balena-etcher &>> $logfile
echo "[OK]"

if [ $install_tlp == 1 ]
then
	echo -n "Starting Battery Saving Service "
	sudo systemctl enable tlp &>> $logfile
	sudo systemctl start tlp &>> $logfile
	echo "[OK]"
fi

echo "Installing PyLint "
sudo pacman -S python-pip
# For Python Code Checking
pip3 install pylint
echo "[OK]"

echo "Create Venv for Maltego and Install maltego requirements "
mkdir -p ~/Dokumente/venv/mcti
python3 -m venv ~/Dokumente/venv/mcti
~/Dokumente/venv/mcti/bin/pip install requests
~/Dokumente/venv/mcti/bin/pip install maltego-trx 
echo "[OK]"

echo "ALL DONE"
echo "If Balena-Etcher is not installed, feel free to open the appimage in the resource folder"
echo "Now continue with Step 3"
