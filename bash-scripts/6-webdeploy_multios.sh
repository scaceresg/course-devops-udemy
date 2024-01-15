#!/bin/bash

USR="devops"
WEBSETUP_FILE="multios_websetup.sh"

for host in `cat remhosts`
do  
    echo "########################################"
    echo "Connecting to $host"
    echo "Pushing script to $host"
    scp $WEBSETUP_FILE $USR@$host:/tmp/ # Push websetup file to the host directory
    echo "Executing script on $host"
    ssh $USR@$host sudo /tmp/$WEBSETUP_FILE
    ssh $USR@$host sudo rm -rf /tmp/$WEBSETUP_FILE
    echo "########################################"
    echo
done