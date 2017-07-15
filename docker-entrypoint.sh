#!/bin/bash

set -e

# Add filebeat as command if needed
if [ "${1:0:1}" = '-' ]; then
	set -- filebeat "$@"
	echo "Here======================"
fi
# Check $config file
#rm -f /etc/filebeat/filebeat.yml

if [ $config ];
then
        echo "Found config=$config, and select $config filebeat.yml folder"
        if [ -e /etc/filebeat/$config ];
        then
                cp /etc/filebeat/$config/filebeat.yml /etc/filebeat/
        else
                echo "config key value $config do not support"
                echo "please check your filebeat git git@github.com:easonlau02/filebeat-scale-out.git"
                echo "Under ~/filebeat-scale-out/config/"
                echo "Now use default folder."
                cp /etc/filebeat/default/filebeat.yml /etc/filebeat/
        fi
        ls -ltr /etc/filebeat/
else
        echo "Not provide key <config>, use default folder."
        echo "please check your filebeat git git@github.com:easonlau02/filebeat-scale-out.git"
        echo "Under ~/filebeat-scale-out/config/"
        echo "Create a new one or select one folder name to config key."
        cp /etc/filebeat/default/filebeat.yml /etc/filebeat/
        ls -ltr /etc/filebeat/
fi
# Fulfill filebeat 5.3.1, change filebeat.yml permission
chmod 600 /etc/filebeat/filebeat.yml
chown root:root /etc/filebeat/filebeat.yml

exec "$@"
