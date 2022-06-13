# Manjaro Post Installation - Step 3

First I recommend to reboot.

Final Steps

* Set your Default Applications in the Settings of Gnome

* Open Manjaro Settings Manager and Manjaro Notifier Manager and take your changes

* Enable AUR, SNAP, Flatpak in Pamac and take your Settings changes

## SSH-Key

```bash
ssh-keygen -t rsa -b 4096 -o -a 100
```

## most

```bash
# Insert into .bashrc file:
export PAGER=most
```

## Reduce Swappiness

Forces System to use as much RAM as possible and reduces hard drive access

```bash
cat /proc/sys/vm/swappiness  # 60 by DEFAULT
sudo nano /etc/sysctl.d/100-archlinux.conf
-> vm.swappiness=10
reboot

cat /proc/sys/vm/swappiness  # should be 10 now
```

## Trim SSD

Enable Trim for SSD - optimize performance of ssd-drive

```bash
sudo systemctl status fstrim.timer  # should be inactive, if not, skip to next heading

sudo systemctl enable fstrim.timer
sudo systemctl start fstrim.timer
sudo systemctl status fstrim.timer  # should be active now
```

## Remove unuseful Applications

Go to Pamac and remove apps

## Open Extensions

... And Enable or Install Extensions

## (optional) Clean Your System and Check for Errors

See on my wiki: [https://n0raitor.com/archlinux](https://n0raitor.com/archlinux)

## Improve (Laptop) App-Opening Performance and Speed

To Improve the Performance on opening applications, feel free to use Preload to Improve the Speed of Opening Applications intro preloading the application resources. 

```bash
sudo pacman -S preload
```

## Done

This is the End of the "Manjaro Post Installer" steps. Feel free to add Issues, if some errors or bug occured or if you have any suggestions

**Appearance**: Feel free to change the appearance e.g. using *flat-remix* of [https://drasite.com/](https://drasite.com/)
