#!/bin/bash
#
#
if [ "$#" -ne 1 ]
then
	echo "Syntax: $0 <docker_image_origin_url>"
	exit 1
fi


ORIG_IMAGE_URL=$1

DEST_HOST=registry.cipsc:5000

read ORIG_HOST ORIG_NAME ORIG_TAG < <(echo ${ORIG_IMAGE_URL}|sed 's#/# #'|rev |sed 's#:# #'|rev)

DEST_IMAGE_URL="${DEST_HOST}/${ORIG_HOST}/${ORIG_NAME}:${ORIG_TAG}"

echo "-----------------------------------------------------------------------"
echo "Orig.: $ORIG_IMAGE_URL"
echo "Dest.: $DEST_IMAGE_URL"
echo "-----------------------------------------------------------------------"
echo
docker pull ${ORIG_IMAGE_URL}
echo
docker tag ${ORIG_IMAGE_URL} ${DEST_IMAGE_URL}
echo
#docker rmi ${ORIG_IMAGE_URL} 
echo

echo "-----------------------------------------------------------------------"
echo "Date and size"
# Obtener Fecha creación y tamaño imagen (bytes):
docker image inspect ${DEST_IMAGE_URL} |jq '.[].Created, .[].Size'
echo

# ej. salida
#	"2016-12-23T02:05:37.299574737Z"
#	557936504
				
# Subida imagen:
echo "-----------------------------------------------------------------------"
echo "Uploading ${DEST_IMAGE_URL}..."
echo
docker push ${DEST_IMAGE_URL} 
echo
echo "Uploaded"
