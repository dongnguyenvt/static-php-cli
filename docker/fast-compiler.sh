#!/bin/sh

# This script needs alpine linux system.

self_dir=$(cd "$(dirname "$0")";pwd)

test "$VER_PHP" = "" && VER_PHP="8.1.14"
test "$ALL_EXTENSIONS" = "" && ALL_EXTENSIONS="all"

# build requirements
apk add bash file wget cmake gcc g++ jq autoconf git libstdc++ linux-headers make m4 libgcc binutils ncurses dialog
# php zlib dependencies
apk add zlib-dev zlib-static
# php mbstring dependencies
apk add oniguruma-dev
# php openssl dependencies
apk add openssl-libs-static openssl-dev openssl
# php gd dependencies
apk add libpng-dev libpng-static
# curl c-ares dependencies
apk add c-ares-static c-ares-dev
# php event dependencies
apk add libevent libevent-dev libevent-static
# php sqlite3 dependencies
apk add sqlite sqlite-dev sqlite-libs sqlite-static
# php libzip dependencies
apk add bzip2-dev bzip2-static bzip2
# php micro ffi dependencies
apk add libffi libffi-dev
# php gd event parent dependencies
apk add zstd-static
# php readline dependencies
apk add readline-static ncurses-static readline-dev

$self_dir/download.sh swoole && \
    $self_dir/download.sh inotify && \
    $self_dir/download.sh mongodb && \
    $self_dir/download.sh event && \
    $self_dir/download.sh redis && \
    $self_dir/download.sh libxml2 && \
    $self_dir/download.sh xz && \
    $self_dir/download.sh protobuf && \
    $self_dir/download.sh curl && \
    $self_dir/download.sh libzip && \
    $self_dir/download.sh libiconv && \
    $self_dir/download-git.sh dongnguyenvt/phpmicro phpmicro && \
    $self_dir/compile-deps.sh && \
    $self_dir/compile-php.sh $PROMPT_1 $VER_PHP $ALL_EXTENSIONS /dist/
