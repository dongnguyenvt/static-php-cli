#!/usr/bin/env bash

self_dir=$(cd "$(dirname "$0")";pwd)

test -d "$self_dir/source/cache/" || mkdir -p "$self_dir/source/cache"

if [ -d "$self_dir/source/cache/$2" ]; then
    echo "Using cache for $2"
    cp -r "$self_dir/source/cache/$2" "$self_dir/source/"
else
    wget -O $self_dir/source/master.zip "$GITHUB_ADDR""https://github.com/$1/archive/master.zip" && \
        cd $self_dir/source/ && \
        unzip master.zip && \
	mv $2-master/ cache/$2 && \
	cp -r cache/$2 ./
fi

# git clone https://$GITHUB_ADDR/$1.git --depth=1 $self_dir/source/$2
