#!/bin/bash

# Remember the expression echo $? returns 0 if a process was successful and non-zero if it wasn't
# Example
# # freeee -m
# > -bash: freeee: command not found
# # echo $?
# > 127
# # free -m
# # echo $?
# > 0

echo "###############################################################"
date 
ls /var/run/httpd/httpd.pid &> /dev/null

if [ $? -eq 0 ] # the process file exists? (Is the process running?)
then
    echo "httpd process is running"
else
    echo "httpd process is NOT running"
    echo "Starting the process"
    systemctl start httpd
    if [ $? -eq 0 ]
    then
        echo "Process started successfully"
    else
        echo "Process starting failed: contact the admin"
    fi
fi

echo "###############################################################"
echo

# After creating this script, you need to create a monitoring script using CRONJOBS
# # crontab -e
# (In the vim editor, add the following monitoring task:)
# ~ # structure: MM HH DOM mm DOW COMMAND
# ~ # example:   30 20  *  *  1-5 script
# ~ * * * * * /opt/scripts/4_monitoring-script.sh &>> /var/log/monit_httpd.log # (create a monitoring log every minute)