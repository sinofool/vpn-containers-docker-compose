FROM alpine:3.18

RUN apk add --update --no-cache curl jq

VOLUME /config

ADD entrypoint.sh /entrypoint.sh

CMD while true; do /entrypoint.sh; sleep 3600; done

