#!/bin/bash
# NOTICE, RUN AS ROOT
mkdir vmware-install-tmp
cd vmware-install-tmp
git clone https://aur.archlinux.org/vmware-workstation15.git

read -p "Install linux headers (use uname -r to find out the version of manjaro and insert it into linuxXX-headers. Maybe use auto complete) Press \"Enter \" to continue"

touch /etc/modules-load.d/vmware.conf 

echo "vmw_vmci" >> /etc/modules-load.d/vmware.conf 
echo "vmmon" >> /etc/modules-load.d/vmware.conf 

cd vmware-workstation15/

makepkg -si

sleep 10

systemctl enable vmware-networks.path     
systemctl enable vmware-usbarbitrator.path  
systemctl enable vmware-authd.service  
systemctl enable vmware-hostd.service 
systemctl enable vmware-networks.service    
systemctl enable vmware-usbarbitrator.service  

echo "JOB DONE"
echo "PLEASE REBOOT NOW"