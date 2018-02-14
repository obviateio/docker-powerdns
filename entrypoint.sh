#!/bin/sh
set -e

# --help, --version
[ "$1" = "--help" ] || [ "$1" = "--version" ] && exec pdns_server $1
# treat everything except -- as exec cmd
[ "${1:0:2}" != "--" ] && exec "$@"

# set allow-axfr-ips by ENV Variable
if $ALLOW_AXFR; then
  sed -r -i "s/^[# ]*allow-axfr-ips=.*/allow-axfr-ips=${ALLOW_AXFR_IPS}/g" /etc/pdns/pdns.conf
  sed -r -i "s/^disable-axfr=.*/disable-axfr=no/g" /etc/pdns/pdns.conf
fi

# set remote-connection-string
if [ ! -z "$REMOTE_CONNECTION_STRING" ]; then
  # Need to use | for sed delim since URL's have /'s
  sed -r -i "s|^remote-connection-string=.*|remote-connection-string=${REMOTE_CONNECTION_STRING}|g" /etc/pdns/pdns.conf
fi


# Run pdns server
trap "pdns_control quit" SIGHUP SIGINT SIGTERM

pdns_server "$@" &

wait
