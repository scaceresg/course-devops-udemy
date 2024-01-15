#!/bin/bash

# 1. Create a remhosts file with the hostnames you want to access
# 2. Set up hostnames and key SSH exchange between hosts
# 3. Use `for` loops to access the hosts remotely:
#       for host in `cat remhosts`; do ssh devops@host uptime; done # (for example)

# Variable Declaration
# PACKAGE="httpd wget unzip"
# SVC="httpd"
URL="https://www.tooplate.com/zip-templates/2098_health.zip"
ART_NAME="2098_health"
TEMPDIR="/tmp/webfiles"

# Check OS (if yum then CentOS, else Ubuntu)
yum --help &> /dev/null

if [ $? -eq 0 ]
then
    # Set variables for CentOS system
    echo "Running setup on CentOS"
    PACKAGE="httpd wget unzip"
    SVC="httpd"

    # Install Dependencies
    echo "#####################################"
    echo "Installing Packages"
    echo "#####################################"
    sudo yum install $PACKAGE -y > /dev/null
    echo

    # Start & Enable Service
    echo "#####################################"
    echo "Start & Enable HTTPD Service"
    echo "#####################################"
    sudo systemctl start $SVC
    sudo systemctl enable $SVC
    echo

    # Create Temp. Directory
    echo "#####################################"
    echo "Start Artifact Deployment"
    echo "#####################################"
    mkdir -p $TEMPDIR
    cd $TEMPDIR
    echo

    wget $URL > /dev/null
    unzip $ART_NAME.zip > /dev/null
    sudo cp -r $ART_NAME/* /var/www/html/
    echo

    # Bounce Service
    echo "#####################################"
    echo "Restarting HTTPD Service"
    echo "#####################################"
    systemctl restart $SVC
    echo

    # Clean Up
    echo "#####################################"
    echo "Removing Temporary Files"
    echo "#####################################"
    rm -rf $TEMPDIR
    echo

    sudo systemctl status $SVC
    ls /var/www/html/

else
    # Set variables for Ubuntu system
    echo "Running setup on Ubuntu"
    PACKAGE="apache2 wget unzip"
    SVC="apache2"

    # Install Dependencies
    echo "#####################################"
    echo "Installing Packages"
    echo "#####################################"
    sudo apt update
    sudo apt install $PACKAGE -y > /dev/null
    echo

    # Start & Enable Service
    echo "#####################################"
    echo "Start & Enable APACHE2 Service"
    echo "#####################################"
    sudo systemctl start $SVC
    sudo systemctl enable $SVC
    echo

    # Create Temp. Directory
    echo "#####################################"
    echo "Start Artifact Deployment"
    echo "#####################################"
    mkdir -p $TEMPDIR
    cd $TEMPDIR
    echo

    wget $URL > /dev/null
    unzip $ART_NAME.zip > /dev/null
    sudo cp -r $ART_NAME/* /var/www/html/
    echo

    # Bounce Service
    echo "#####################################"
    echo "Restarting APACHE2 Service"
    echo "#####################################"
    systemctl restart $SVC
    echo

    # Clean Up
    echo "#####################################"
    echo "Removing Temporary Files"
    echo "#####################################"
    rm -rf $TEMPDIR
    echo

    sudo systemctl status $SVC
    ls /var/www/html/  
fi