FROM python:3.9.7-alpine3.14
#FROM alpine:3.14.2
LABEL maintainer="Manuel Ramirez <mramirez@leal.co>"

ARG KUBE_VERSION="1.22.2"
COPY entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh && \
    apk add --no-cache --update \
    openssl \
    curl \
    ca-certificates \
    && pip3 install awscli \
    && curl -L https://storage.googleapis.com/kubernetes-release/release/v$KUBE_VERSION/bin/linux/amd64/kubectl -o /usr/local/bin/kubectl \
    && chmod +x /usr/local/bin/kubectl \
    && rm -rf /var/cache/apk/*

ENTRYPOINT ["/entrypoint.sh"]
CMD ["cluster-info"]