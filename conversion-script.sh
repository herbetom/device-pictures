#!/bin/bash

set -eEu
set -o pipefail  # avoid masking failures in pipes
shopt -s nullglob  # do not run loops if the glob has not found anything

# convert svg to jpg and png if needed
CREATE_JPG=${CREATE_JPG:-true}

CURRENT_DIR=$PWD

if [[ "${CREATE_JPG}" == "true" ]]; then
    echo "creating jpg folders"
    mkdir -p pictures-jpg
    mkdir -p pictures-png
fi

for file in pictures-svg/*.svg; do
    # get file names, without dir
    devicename=${file##pictures-svg/}
    # remove file extension
    devicename=${devicename%.svg}

    if [ "$file" == "pictures-svg/no_picture_available.svg" ]; then
        devicename="no_picture_available"
    fi

    if [[ -L "pictures-svg/$devicename.svg" ]]; then
        link_filepath=$(readlink -f "pictures-svg/$devicename.svg")
        link_file=$(basename "$link_filepath")
        link_name="${link_file%.svg}"
        echo "Symlinking $devicename to $link_name. Skipping conversion."
        ln -sf "$link_name.png" "pictures-png/$devicename.png"
        ln -sf "$link_name.jpg" "pictures-jpg/$devicename.jpg"
    else
        inkscape "pictures-svg/$devicename.svg" --batch-process --export-type=png --export-filename="pictures-png/$devicename.png" --export-background-opacity=0
        # as not all SVG are updated to have no borders, trim unnecessary white borders from png
        mogrify -trim "pictures-png/$devicename.png"
        # even though mogrify trims the png, we need to trim again for the jpg
        convert "pictures-png/$devicename.png" -resize 65536@\> -background white -flatten -alpha off -trim "pictures-jpg/$devicename.jpg"
    fi
done;
