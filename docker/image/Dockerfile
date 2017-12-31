FROM prom/prometheus:v2.0.0 AS prometheus
FROM golang:alpine AS envsubst

RUN set -x && \
  apk add --update git && \
  go get -u -v github.com/a8m/envsubst/cmd/envsubst

FROM alpine
COPY --from=envsubst /go/bin/envsubst /usr/local/bin/envsubst
COPY --from=prometheus /bin/prometheus /usr/local/bin/prometheus

RUN set -x && \
  apk add --update bash ca-certificates

ADD ./entrypoint.sh /usr/local/bin/entrypoint
ADD ./config /etc/prometheus/config

ENTRYPOINT [ "entrypoint" ]

