autoTLC-MS_manager installation
===========

![TLC-MS_manager screenshot](TLC-MS_manager.png)

## Ubuntu 18.04.5 LTS image

Follow [this link](https://jlubox.uni-giessen.de/dl/fi3pKFDKArQEdTxdwdA8bkHB/TLCMS_Ubuntu18.gz) to download an image of Ubuntu 18.04.5 with the installed TLC-MS_manager, last updated: 2021-02-10 (3.7 GB), and copy it onto an USB stick.

Higher versions of Ubuntu cannot be used, because some needed libraries are not available for Ubuntu >18.

To flash the image, boot the NUC from DVD (Ubuntu 18.04.5 LTS) (Live-CD). <br />
- Therefore, download Ubuntu 18 (https://releases.ubuntu.com/18.04/) and flash the ISO onto a DVD.
- Attach the DVD to the NUC and start the PC. On booting select "Try Ubuntu without installation" and wait for the booting process. 
- Attach the USB stick with the downloaded image file (TLCMS_Ubuntu18.gz).<br />
- Open a terminal and type:
- ```sudo fdisk -l``` to identify the NUC-SSD (typically /dev/sda) and the USB stick (typically /dev/sdb).<br />
- Mount the USB stick to the folder /mnt:
```sudo mount /dev/sdb /mnt``` <br />
- Unmount the SSD:
```sudo umount /dev/sda``` followed by ```sudo su```, to get root privileges <br />
- Start flashing with: ```cat /mnt/TLCMS_Ubuntu18.gz | gunzip -d -c | dd of =/dev/sda bs=32k```.<br />
- After finishing, check the values of 'in' and 'out', which should be fully identical, if nothing went wrong.<br />
- Reboot the NUC while detaching the DVD.
- User name: pi, password: tlcms
- Configure Ubuntu for your purposes (language, keyboard).
- Configure a proper time server:
```
sudo nano /etc/systemd/timesyncd.conf
```
"edit the line fallbackNTP= ... followed by"
```
sudo timedatectl set-ntp true
sudo reboot
```

- After date and time is correctly synchronized, perform update und upgrade:
```
sudo apt update
sudo apt upgrade
```


## Alternatively, manual installation of TLC-MS_manager on NUC with Ubuntu 18.04.5 LTS already installed, using the installation script

First install the git library:

```sudo apt install git```

Then clone this github repository:

```git clone https://github.com/OfficeChromatography/TLC-MS_manager.git```

### Installation 

In the downloaded folder ```home/TLC-MS_manager```, there is an installation script (TLC-MS_manager_Ubuntu-18-04_install.sh) to be executed (last updated and tested 2021-02-10). Therefore, open the file ```sudo_bash.txt```, and copy the repective command line into the terminal.

In case of installation problems, the log file ```TLC-MS_manager-Ubuntu_install.txt``` (in home/) can be checked for error messages concerning, for example, missing dependencies.

## Raspberry Pi 4B image

Follow [this link](https://jlubox.uni-giessen.de/dl/fiUZYxykrZFXuFq645QXKEC6/TLCMS_RPi4.img.gz) to download an image of a Raspberry Pi OS with the installed TLC-MS_manager, last updated 2021-02-10 (2.1 GB).

- Flash the image onto an SD card (>= 16 GB), best using the Raspberry Pi Imager (https://www.raspberrypi.org/software/).
- Insert the SD card into the Raspberry Pi 4B and boot the system.
- Configure the Raspberry Pi for your purposes (language, keyboard).
- User name: pi, password: tlcms
- Configure a proper time server:
```
sudo nano /etc/systemd/timesyncd.conf
```
"edit the line fallbackNTP= ... followed by"
```
sudo timedatectl set-ntp true
sudo reboot
```

- After date and time is correctly synchronized, perform update und upgrade:
```
sudo apt-get update
sudo apt-get upgrade
```

## Alternatively, manual installation of TLC-MS_manager on a Raspberry Pi 4B with an OS already installed, using the installation script

There is a different installation script for the Raspberry Pi in the downloaded folder ```home/pi/TLC-MS_manager```. Use the respective sudo bash command to be found in the file ```sudo_bash.txt```.

Unfortunately, the new Ubuntu 20.10 OS for the Raspberry Pi 4B does not work, because some needed libraries are not available for this OS.

## Run

### Started at reboot with crontab

Crontab is a job scheduler for UNIX-like system. The file can be accessed with the following command and the lines inside will be executed at the appropriate moment.

```sudo crontab -e```

Once in the editor, add this line for both the NUC and Raspberry Pi:

```@reboot Rscript /home/pi/TLC-MS_manager/app_exec.R```


After reboot, the TLC-MS_manager will be available in the browser at http://127.0.0.1 (localhost). <br />
Therefore, best configure the browser to start with the custom URL http://127.0.0.1/. <br />

If a static IP had been set, the application will also be available at the IP (in the browser) from a remote computer in the network.



### Directly from R (in case of problems to catch the errors)

Being in a terminal: 

```cd TLC-MS_manager```

```R```

```shiny::runApp()```


## Documentation

A pdf is available in the downloaded folder ```TLC-MS_manager/Instruction```.

The same instruction is also available in the "Read me" tab of the TLC-MS_manager software.

