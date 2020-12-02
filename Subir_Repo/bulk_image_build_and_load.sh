#!/bin/bash

#cat images_to_build.txt |while read name tag dockerfile; do ./build_and_upload_image_to_registry.sh $name $tag $dockerfile; done
cat images_to_upload.txt |while read orig_url; do ./upload_image_to_registry.sh $orig_url; done
