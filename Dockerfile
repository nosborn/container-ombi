FROM debian:13.3-slim

ARG VERSION

RUN export DEBIAN_FRONTEND=noninteractive \
    && apt-get update \
    && apt-get install -y --no-install-recommends \
        ca-certificates \
        curl \
        libicu76 \
        libssl3 \
        libsqlite3-0 \
    && rm -rf \
        /var/lib/apt/lists/* \
    && mkdir -p /app \
    && chown 1000:1000 /app

USER 1000:1000
WORKDIR /app

RUN cd /app \
    && curl -fLOsS \
        --output-dir /tmp \
        --url "https://github.com/Ombi-app/Ombi/releases/download/v${VERSION:?}/linux-x64.tar.gz" \
    && tar -xzf /tmp/linux-x64.tar.gz \
    && rm /tmp/linux-x64.tar.gz

EXPOSE 5000
VOLUME /data

ENTRYPOINT ["/app/Ombi", "--storage=/data"]
