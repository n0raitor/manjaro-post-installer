# Manjaro Post Installation - Step 1

General INIT Maintenance:

* Go through the settings of Plasma and adjust it to your choice.
  
  * Add Keyboard shortcut: 
    
    * gnome-terminal (on Ctrl+Alt+T)
    
    * dolphin (on Ctrl+Alt+E)

* Enable Firewall
  
  * ```bash
    sudo pacman -S ufw ufw-extras gufw
    sudo systemctl enable ufw.service
    sudo ufw enable
    ```

* Take a Snapshot with Timeshift
  
  * I recommend to use a external Drive for that.

* Edit /etc/pacman.conf
  
  * uncommend color and parallel downloads
  * add ILoveCandy

* Open Pamac
  
  * Use Local Mirrors in Settings
  * Enable AUR + Snap + Flatpak (in Settings)
  * Update your System

* reboot your system and continue on *step 2*
  
  * run ./manjaro-post-install-step-2.sh as root (e.g. with sudo)
