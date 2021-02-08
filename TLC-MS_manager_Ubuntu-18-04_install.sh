#install script for OC_Manager
#!/bin/bash
echo""
echo "***********************************************************"
echo ""
echo "You are going to install TLC-MS_manager on your PC."
echo ""
echo "Don't worry, this will take some hours!"
echo ""
echo "Are you ready to start? (y/n)"
read userinput
if [ "$userinput" == "y" ]
then
  echo ""
  echo "Installing r-base"
  echo ""
  yes | sudo apt install apt-transport-https software-properties-common
  yes | sudo echo 'deb http://cran.rstudio.com/bin/linux/ubuntu bionic-cran35/' | sudo tee -a /etc/apt/sources.list
  yes | gpg --keyserver keyserver.ubuntu.com --recv-key E298A3A825C0D65DFD57CBB651716619E084DAB9
  yes | gpg -a --export E298A3A825C0D65DFD57CBB651716619E084DAB9 | sudo apt-key add -
  echo ""
  yes | sudo apt-get update
  yes | sudo apt-get install r-base r-base-dev
  echo ""  
  echo "Installing libraries"
  echo ""
  yes | sudo apt-get install libssl-dev libcurl4-openssl-dev libtiff5-dev
  echo ""
  yes | sudo apt-get update
  echo ""
  yes | sudo apt-get install python-serial
  echo ""
  echo "Installing more libraries"
  echo ""
  yes | sudo apt-get install libssh2-1-dev libboost-atomic-dev libxml2-dev
  echo ""
  yes | sudo apt-get update
  echo ""
  echo "Installing more libraries"
  echo ""
  yes | sudo apt-get install mesa-common-dev libglu1-mesa-dev libx11-dev libgit2-dev
  echo ""
  yes | sudo apt-get update
  echo ""
  echo "Installing Python 2.7"
  echo ""
  yes | sudo apt-get install python2.7
  echo ""
  yes | sudo apt-get install python-pip
  echo ""
  # yes | sudo apt-get install libpython2.7
  echo ""
  yes | sudo apt-get update
  echo ""
  echo "Removing packages not used anymore"
  yes | sudo apt autoremove
  echo ""
  echo "Installing R packages"
  echo ""
  yes | sudo su - -c "R -e \"install.packages('devtools', repos='http://cran.rstudio.com/')\""
  yes | sudo apt-get update
  yes | sudo su - -c "R -e \"devtools::install_github('rstudio/shiny')\""
  yes | sudo apt-get update
  yes | sudo su - -c "R -e \"devtools::install_github('rstudio/shinydashboard')\""
  yes | sudo apt-get update
  yes | sudo su - -c "R -e \"devtools::install_version('serial', version = '3.0', repos='http://cran.rstudio.com/')\""
  yes | sudo apt-get update
  yes | sudo su - -c "R -e \"devtools::install_version('reticulate', version = '1.16', repos='http://cran.rstudio.com/')\""
  yes | sudo apt-get update
  yes | sudo su - -c "R -e \"install.packages('shinyBS', repos='http://cran.rstudio.com/')\""
  yes | sudo apt-get update
  yes | sudo su - -c "R -e \"install.packages('shinyalert', repos='http://cran.rstudio.com/')\""
  yes | sudo apt-get update
  yes | sudo su - -c "R -e \"devtools::install_version('rgl', version = '0.100.54', repos='http://cran.rstudio.com/')\""
  yes | sudo apt-get update
  yes | sudo su - -c "R -e \"devtools::install_github('OfficeChromatography/DLC')\""
  yes | sudo su - -c "R -e \"devtools::install_github('jrowen/rhandsontable')\""
  echo ""
  yes | sudo apt-get update
  echo "Performing reboot"
  sudo reboot
else
  echo "The installation was skipped"
fi
