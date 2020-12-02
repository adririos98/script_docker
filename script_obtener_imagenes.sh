#!/usr/bin/sh
if [[ $# -eq 0 ]]; then
        echo "Usage: $0 <backup_dir>"
        exit
fi

destination=$1

docker images | awk -v destination="$destination" '{
if ($1 != "REPOSITORY")
        {
                original = $1;
                size = $5;
                gsub("/","_",$1);
                normalised_container_name = $1
                print "Container: "original" => "destination"/"normalised_container_name".tgz";
                system("docker save "original" | gzip -c > "destination"/"normalised_container_name".tgz")
        };
}'



containers=$(ls $destination/*.tgz)

for container in $containers
do
        normalised_container_name=${container//\//_}
        echo "Container: $container => $1/$normalised_container_name.tgz"
        if [[ -s $1/$normalised_container_name.tgz ]]; then
                echo "File $1/$normalised_container_name already exists with filesize > 0, skipping backup..."
                continue
        fi

done
