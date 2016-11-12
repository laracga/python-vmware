#!/bin/bash -x

#limpieza de ficheros temporales
rm -f /tmp/nodes.txt

############################## SNAPSHOTS #####################################

#obtener lista de nodos del proyecto según la query enviada como parámetro $1 y guardarla en fichero temporal /tmp/nodes.txt
cd /var/lib/jenkins
echo "************************** Node Snapshot *****************************"

knife search node "$1" | grep "Node Name" | awk -F' ' '{ print $3 }' >> /tmp/nodes.txt

#bucle para leer linea a linea el fichero de nodos
fecha=`date +%Y-%m`
while IFS= read -r line
do
  echo "********************* NODO: $line **********************************"
  #obtener a que vcenter pertenece el nodo consultando el attribute de Chef vcenter
  cd /var/lib/jenkins
  vcenter=$(knife node show $line -a vcenter | grep vcenter: | cut -d " " -f 4)

  #lanzar la creación del snapshot en vmware
  cd /var/Tools
  python snapshot_tool.py -s ${vcenter} -u lcancela@soliumes -p susiyz07. -m $line create -sn "$fecha-$line-autopatch" -sd "Created for autopatch $fecha-$line" #TODO eliminar este script y el job que lo ejecuta para integrar la creacion de snapshots en autopatch.sh

done <"/tmp/nodes.txt"
