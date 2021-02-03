autoTLC-MS_manager
===========

## Shiny app to operate the autoTLC-MS interface

![TLC-MS_manager screenshot](TLC-MS_manager.png)

## Ubuntu 16.04 LTS image

Follow [this link](https://jlubox.uni-giessen.de/dl/fi5d7vosAXVt6w1cAmn4RBZ2/OC_manager_DF.gz) to download an image of Ubuntu 16.04 with the installed TLC-MS_manager, last updated: 2021-01-15 (1 GB).


## Manual Installation using the installation script

First install the git library:

```sudo apt install git```

The clone this github repository:

```
git clone https://github.com/OfficeChromatography/TLC-MS_manager.git
```

### Installation on NUC with Ubuntu 16.04 LTS installed

In the downloaded folder ```home/pi/TLC-MS_manager```, you will find an installation script (TLC-MS_manager_Ubuntu-16-04_install.sh) to be executed (last updated and tested 2021-01-15). Therefore, open the file ```sudo_bash.txt```, and copy the repective command line into the terminal.

In case of installation problems, the log file ```TLC-MS_manager-Ubuntu_install.txt``` (in home/pi) can be checked for error messages concerning, for example, missing dependencies.

### Installation on Raspberry Pi 4B with Raspbian OS installed

There is a different installation script for the Raspberry Pi in the downloaded folder ```home/pi/TLC-MS_manager```. Use the respective sudo bash command to be found in the file ```sudo_bash.txt```.
Unfortunately, the new Ubuntu 20.10 OS for the Raspberry Pi 4B does not work, because it uses the R version 4.0.2 that is not compatible with the autoTLC-MS_manager.
## Run

### Started at reboot with crontab

Crontab is a job scheduler for UNIX-like system. The file can be accessed with the following command and the lines inside will be executed at the appropriate moment.

```
sudo crontab -e
```
Once in the editor, add this line which will launch the application at reboot. 

```
@reboot Rscript /home/pi/TLC-MS_manager/app_exec.R
```
After reboot, the TLC-MS_manager will be available in the NUC PC browser at https://127.0.0.1. Therefore, best configure the browser to start with the custom URL https://127.0.0.1/.

If a static IP had been set, the application will also be available at the IP (in the browser) from a remote computer in the network.



### Directly from R (in case of problems to catch the errors)

Being in a terminal: 

```
cd TLC-MS_manager
R
shiny::runApp()
```


## Documentation

A pdf is available in the folder ```Instruction```.

The same instruction is also available in the "Read me" tab of the TLC-MS_manager software.

