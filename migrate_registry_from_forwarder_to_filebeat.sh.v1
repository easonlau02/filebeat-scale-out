#!/bin/bash

file=$1
if [ $file ]
then
	if cat $file | grep "\[" ;
	then
		echo "Not logstash-forwarder registry, ignore to migrate"
	else
		regi=./registry
		cat $file > $regi
		echo purge filepath: at begining of element.
		sed -i -e 's/\"[\/a-zA-Z0-9_\-\s\.]*\"\:{/{/g' $regi
		echo add key "FileStateOS":{
		sed -i -e 's/\"inode/\"FileStateOS\"\:{\"inode/g' $regi
		echo add } for "FileStateOS" key
		sed -i -e 's/}}$/}}]/g' $regi
		sed -i -e 's/},/}},/g' $regi
		echo "revise beggining and end { & }"
		sed -i -e 's/^{/[/g' $regi
		cat $regi
		echo ==========================================
		echo Put $regi file under "/var/lib/filebeat/"
		echo ==========================================
	fi
else
	echo usage : $0 [filepath]
fi
