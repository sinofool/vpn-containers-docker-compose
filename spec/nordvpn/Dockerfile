FROM ubuntu:22.04

RUN apt-get update && \
    apt-get install -y wget iputils-ping curl && \
    wget -O /tmp/nordrepo.deb https://repo.nordvpn.com/deb/nordvpn/debian/pool/main/nordvpn-release_1.0.0_all.deb && \
    apt-get install -y /tmp/nordrepo.deb && \
    apt-get update && \
    apt-get install -y nordvpn=3.16.8 && \
    apt-get remove -y wget nordvpn-release && \
    rm /tmp/nordrepo.deb && \
    apt-get clean
ADD connect.sh /connect.sh
ADD healthcheck.sh /healthcheck.sh
HEALTHCHECK CMD /healthcheck.sh

