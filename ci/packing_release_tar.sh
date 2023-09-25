#!/bin/bash

function extract_to_build() {
    local target_file_name=$1
    local target_file_dir=./build

    mkdir -p $target_file_dir
    tar -xvf $target_file_name -C $target_file_dir
    rm -rf $target_file_name

    # the extracted files have many tar files and manifest files
    # The largest tar file is named <hash>.tar, we need to extract it
    cd $target_file_dir
    local largest_tar_file=$(find . -name "*.tar" | xargs ls -l | sort -k 5 -r | head -n 1 | awk '{print $NF}')
    
    # rename this largest tar file to be target_file_name
    mv $largest_tar_file $target_file_name
}


function main() {
    # The only one parameter is the target file name 
    if [ $# -ne 1 ]; then
        echo "Usage: $0 <target_file_name>"
        exit 1
    fi

    local target_file_name=$1
    extract_to_build $target_file_name
}

main "$@"
