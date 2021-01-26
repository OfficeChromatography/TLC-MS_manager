FROM python:2.7-buster
MAINTAINER Lucas M. Sing

ENV PYTHONUNBUFFERED 1

RUN echo "You are going to install OC_manager2 on your Raspberry Pi with Raspberry Pi OS lite.\n\n*********************\
        ***************************************\n\n\nYou are going to install OC_manager2 on your Raspberry Pi with Ras\
        pberry Pi OS lite.You are going to install OC_manager2 on your Raspberry Pi with Raspberry Pi OS lite.\n\nDon't\
        worry, this will take some time!\n\nAre you ready to start? (y/n)\n"

RUN apt-get update && apt-get upgrade -y

# "Installing r-base"
RUN apt-get install r-base -y

#"Installing libraries"
RUN apt-get install libssl-dev libcurl4-openssl-dev r-cran-rgl libtiff5-dev python-serial git libssh2-1-dev libboost-atomic-dev libxml2-dev mesa-common-dev libglu1-mesa-dev libx11-dev libgit2-dev -y

#"Removing packages not used anymore"
RUN apt autoremove -y

RUN R -e "install.packages('devtools', repos='http://cran.rstudio.com/')"
RUN R -e "devtools::install_version('later', version = '1.1.0.1', repos='http://cran.rstudio.com/')"
RUN R -e "devtools::install_github('rstudio/shiny')"
RUN R -e "devtools::install_github('rstudio/shinydashboard')"
RUN R -e "devtools::install_version('serial', version = '3.0', repos='http://cran.rstudio.com/')"
RUN R -e "devtools::install_version('reticulate', version = '1.16', repos='http://cran.rstudio.com/')"
RUN R -e "devtools::install_version('DT', version = '0.13', repos='http://cran.rstudio.com/')"
RUN R -e "install.packages('shinyBS', repos='http://cran.rstudio.com/')"
RUN R -e "install.packages('shinyalert', repos='http://cran.rstudio.com/')"
RUN R -e "devtools::install_version('rgl', version = '0.100.54', repos='http://cran.rstudio.com/')"
RUN R -e "devtools::install_github('jrowen/rhandsontable')"

RUN mkdir /TLC-MS_manager
WORKDIR /TLC-MS_manager
COPY ./ /TLC-MS_manager

RUN export PYTHONPATH='/usr/lib/python2.7/dist-packages'
ENV PYTHONPATH='/usr/lib/python2.7/dist-packages'

CMD R -e 'shiny::runApp(port=8000, host="0.0.0.0" ,launch.browser="false")'

