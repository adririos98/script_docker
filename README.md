# script_docker
Scripts para facilitar el uso de Docker.

Los scripts se deben utilizar de la siguiente forma:

sh [Nombre-script] [</Ruta_guardado>]

--------------------------------------------------------------------------------------------------------------------------------
El Script_SubirImagenesRepo se debe usar de la siguiente forma:
Crear fichero llamado images_to_upload.txt y agregar en el los nombres de los contenedores a subir con su respectiva etiqueta.

En el caso de necesitar la subida de más de un contenedor, debe agregar tantas líneas como sea necesario.
Ejecutar el siguiente comando para completar la subida.
# cat images_to_upload.txt |while read orig_url; do ./upload_image_to_registry.sh $orig_url; done

- El script upload_image_to_registry.sh es adjuntado en este correo.
- El fichero images_to_upload.txt y el script upload_image_to_registry.sh deben estar en el mismo directorio o en el caso de estar en directorios diferentes, se debe añadir la ruta completa de su ubicación.
