#!/usr/bin/env bash

echo 'Introduzca el nombre de la imagen:'
read imagen
echo 'Introduzca el nombre del servicio'
read servicio

echo 'Los datos introducidos son los siguientes:'
echo ' - Nombre imagen:' $imagen
echo ' - Nombre del servicio:' $servicio

while true; do
echo
read -p "¿Acepta actualizar la imagen del servicio seleccionado? (yes o no) " yn
case $yn in
yes ) break;;
no ) exit;;
* ) echo "por favor responda yes o no";;
esac
done

docker service update --image $imagen $servicio;
echo -e "\n# oracle_wso2eianalytics service tasks";
docker service ps $servicio;
echo -e "\n# oracle_wso2eianalytics service inspect";
docker service inspect --pretty $servicio
