FROM alpine:3.17

# define script basic information
# Version of this Dockerfile
ENV SCRIPT_VERSION=1.5.1

# build requirements
RUN apk add --no-cache bash file wget cmake gcc g++ jq autoconf git libstdc++ linux-headers make m4 libgcc binutils ncurses dialog upx > /dev/null
## php zlib dependencies
#RUN apk add zlib-dev zlib-static > /dev/null
## php mbstring dependencies
#RUN apk add oniguruma-dev > /dev/null
## php openssl dependencies
#RUN apk add openssl-libs-static openssl-dev openssl > /dev/null
## php gd dependencies
#RUN apk add libpng-dev libpng-static > /dev/null
## curl c-ares dependencies
#RUN apk add c-ares-static c-ares-dev > /dev/null
## php event dependencies
#RUN apk add libevent libevent-dev libevent-static > /dev/null
## php sqlite3 dependencies
#RUN apk add sqlite sqlite-dev sqlite-libs sqlite-static > /dev/null
## php libzip dependencies
#RUN apk add bzip2-dev bzip2-static bzip2 > /dev/null
# php micro ffi dependencies
RUN apk add --no-cache libffi libffi-dev > /dev/null
## php gd event parent dependencies
#RUN apk add zstd-static > /dev/null
## php readline dependencies
#RUN apk add readline-static ncurses-static readline-dev > /dev/null

RUN mkdir /app

WORKDIR /app

COPY ./* /app/

RUN chmod +x /app/*.sh

#RUN ./download.sh swoole && \
#    ./download.sh inotify && \
#    ./download.sh mongodb && \
#    ./download.sh event && \
#    ./download.sh redis && \
#    ./download.sh libxml2 && \
#    ./download.sh xz && \
#    ./download.sh curl && \
#    ./download.sh libzip && \
#    ./download.sh libiconv && \
#    ./download-git.sh dixyes/phpmicro phpmicro
RUN ./download-git.sh dongnguyenvt/phpmicro phpmicro

RUN ./compile-deps.sh
RUN echo -e "#!/usr/bin/env bash\n/app/compile-php.sh \$@" > /bin/build-php && chmod +x /bin/build-php
