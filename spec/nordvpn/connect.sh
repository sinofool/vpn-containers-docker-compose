#!/bin/bash

rm -f /run/nordvpn/nordvpn.pid /run/nordvpn/nordvpnd.sock
/etc/init.d/nordvpn start 
for retry in {1..15}
do 
    sleep 1
    echo retry $retry
    nordvpn status && break
done
nordvpn status || exit 99

trap "echo Stopping; 
nordvpn disconnect;
nordvpn logout --persist-token;
/etc/init.d/nordvpn stop;
echo Stopped;
" SIGTERM

nordvpn set killswitch on
nordvpn login --token $AUTH_TOKEN
nordvpn connect $@ || exit 10

for SUBNET in $WHITELIST_SUBNETS
do
    echo "adding whitelist subnet $SUBNET"
    nordvpn whitelist add subnet $SUBNET
done

for PORT in $WHITELIST_PORTS
do
    echo "adding whitelist port $PORT"
    nordvpn whitelist add port $PORT protocol TCP
done

while true
do
    nordvpn status || exit 1
    nordvpn status | grep "Status: Connected" || exit 2
    curl --max-time 3.0 --retry 3 --retry-all-errors https://example.com/notme.php || exit 3
    sleep 1
done

