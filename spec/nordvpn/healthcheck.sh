#!/bin/bash

nordvpn status || exit 1
nordvpn status | grep "Status: Connected" || exit 2
curl --max-time 3.0 --retry 3 --retry-all-errors https://example.com/notme.php || exit 3

exit 0

