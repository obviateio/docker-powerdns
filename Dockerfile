FROM alpine
LABEL MAINTAINER="Jon Davis <github@konsoletek.com>"

ENV REFRESHED_AT="2018-02-14" \
    POWERDNS_VERSION=4.1.0 \
    ALLOW_AXFR=false \
    ALLOW_AXFR_IPS="127.0.0.1/32" \
    REMOTE_CONNECTION_STRING="http:url=http://localhost:1234/dns"

RUN apk --update add libstdc++ libgcc libcurl openssl-dev && \
    apk add --virtual build-deps g++ make curl boost-dev  && \
    curl -sSL https://downloads.powerdns.com/releases/pdns-$POWERDNS_VERSION.tar.bz2 | tar xj -C /tmp && \
    cd /tmp/pdns-$POWERDNS_VERSION && \
    ./configure --prefix="" --exec-prefix=/usr --sysconfdir=/etc/pdns --with-modules="remote" --without-lua && \
    make && make install-strip && cd / && \
    mkdir -p /etc/pdns/conf.d && \
    addgroup -S pdns 2>/dev/null && \
    adduser -S -D -H -h /var/empty -s /bin/false -G pdns -g pdns pdns 2>/dev/null && \
    apk del --purge build-deps && \
    rm -rf /tmp/pdns-$POWERDNS_VERSION /var/cache/apk/*

ADD pdns.conf /etc/pdns/
ADD entrypoint.sh /

EXPOSE 53/tcp 53/udp 8081/tcp

ENTRYPOINT ["/entrypoint.sh"]
