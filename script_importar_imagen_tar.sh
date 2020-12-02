#!/usr/bin/sh
if [[ $# -eq 0 ]]; then
        echo "Usage: $0 <backup_dir>"
        exit
fi

containers=$(ls $1/*.tgz)

for container in $containers
do
        stripped_container=$(basename $container .tgz)
        echo "Container: $container => ${stripped_container//_/\/}"
        gzip -d -c $container | docker load
done
