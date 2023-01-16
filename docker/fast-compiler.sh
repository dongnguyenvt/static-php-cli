#!/bin/sh

# This script needs alpine linux system.

self_dir=$(cd "$(dirname "$0")";pwd)

test "$VER_PHP" = "" && VER_PHP="8.1.14"
test "$USE_BACKUP" = "" && USE_BACKUP="no"
test "$ALL_EXTENSIONS" = "" && ALL_EXTENSIONS="all"

LINK_APK_REPO='mirrors.ustc.edu.cn'
LINK_APK_REPO_BAK='dl-cdn.alpinelinux.org'

if [ "${USE_BACKUP}" = "yes" ]; then \
    echo "Using backup address..." && sleep 1s
    LINK_APK_REPO=${LINK_APK_REPO_BAK}
else
    echo "Using original address..." && sleep 1s
fi

sed -i 's/dl-cdn.alpinelinux.org/'${LINK_APK_REPO}'/g' /etc/apk/repositories

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

test "$USE_BACKUP" = "no" && PROMPT_1="mirror" || PROMPT_1="original"

$self_dir/download.sh swoole ${USE_BACKUP} && \
    $self_dir/download.sh inotify ${USE_BACKUP} && \
    $self_dir/download.sh mongodb ${USE_BACKUP} && \
    $self_dir/download.sh event ${USE_BACKUP} && \
    $self_dir/download.sh redis ${USE_BACKUP} && \
    $self_dir/download.sh libxml2 ${USE_BACKUP} && \
    $self_dir/download.sh xz ${USE_BACKUP} && \
    $self_dir/download.sh protobuf ${USE_BACKUP} && \
    $self_dir/download.sh curl ${USE_BACKUP} && \
    $self_dir/download.sh libzip ${USE_BACKUP} && \
    $self_dir/download.sh libiconv ${USE_BACKUP} && \
    $self_dir/download-git.sh dongnguyenvt/phpmicro phpmicro ${USE_BACKUP} && \
    $self_dir/compile-deps.sh && \
    $self_dir/compile-php.sh $PROMPT_1 $VER_PHP $ALL_EXTENSIONS /dist/
