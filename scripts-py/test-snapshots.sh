#!/bin/bash

vcenter=vgvcenter01

#limpieza de ficheros temporales
rm -f /tmp/nodes.txt
rm -f /tmp/nodes-snapshot.txt

echo "************************** Node Snapshot *****************************"

cd /var/lib/jenkins
knife search node "name:vgtest01 OR name:vgtest02" | grep "Node Name" | awk -F' ' '{ print $3 }' >> /tmp/nodes.txt

fecha=`date +%Y-%m`

while IFS= read -r line
do
  echo "$line" 
  cd /var/Tools

  echo "check snapshot"
  echo $fecha-$line

  #Esperamos a que se haga el snapshot
  #sleep 3m

  python snapshot_tool.py -s $vcenter -u lcancela@soliumes -p susiyz07. -m $line list | grep $fecha-$line
  if [ $? -eq 0 ];then
      echo $list > /tmp/nodes-snapshot.txt
  fi

done <"/tmp/nodes.txt"


echo "****************** NODES: ***************************"
cat /tmp/nodes.txt
echo "****************** NODES SNAPSHOT OK: ***************************"
cat /tmp/nodes-snapshot.txt


