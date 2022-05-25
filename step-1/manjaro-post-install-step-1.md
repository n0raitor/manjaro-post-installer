# Manjaro Post Installation - Step 1

For HiDPI (choose one):

* Open Settings -> Display and Adjust Scaling to 200%

* Open Gnome Tweaks -> Fonts and Adjust Scaling to 1.25



General INIT Maintenance:

* Go through the settings of Gnome and adjust it to your choice.
  
  * We will edit the default Applications later
  
  * Add Keyboard shortcut: 
    
    * gnome-terminal (on Ctrl+Alt+T)
    
    * nautilus (on Ctrl+Alt+E)

* Enable Firewall

* Take a Snapshot with Timeshift
  
  * I recommend to use a external Drive for that.

* Edit /etc/pacman.conf

  * uncommend color and parallel downloads
  * add ILoveCandy

* Open Pamac

  * Use Local Mirrors in Sessings
  * Update your System

* Open Gnome Add Folder and Add all not needed default apps to a folder (or do this in the app overview)

* reboot your system and continue on *step 2*

  * run ./manjaro-post-install-step-2.sh as root (e.g. with sudo)
  
 

