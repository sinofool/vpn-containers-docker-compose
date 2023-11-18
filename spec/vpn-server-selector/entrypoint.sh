#!/bin/sh

MULLVAD_SERVERS=$(curl https://api.mullvad.net/public/relays/wireguard/v2 | jq -r '.wireguard.relays | sort_by(.weight) | reverse | .[] | select(.location=="us-sea" or .location=="us-nyc") | .hostname' | head -n 17 | awk 'ORS=","' | sed 's/,$//g')
echo "$(date +%FT%T%Z) Mullvad servers: $MULLVAD_SERVERS"
sed -i "s/SERVER_HOSTNAMES=.*/SERVER_HOSTNAMES=$MULLVAD_SERVERS/" /config/env/mullvad.env

NORDVPN_SERVERS=$(curl "https://api.nordvpn.com/v1/servers/recommendations?filters\[servers_technologies\]\[identifier\]=wireguard_udp&limit=17" | jq -r 'sort_by(.load) | .[].hostname' | awk 'ORS=","' | sed 's/,$//g')
echo "$(date +%FT%T%Z) NordVPN servers: $NORDVPN_SERVERS"
sed -i "s/SERVER_HOSTNAMES=.*/SERVER_HOSTNAMES=$NORDVPN_SERVERS/" /config/env/nordvpn.env

