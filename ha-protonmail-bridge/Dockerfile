ARG BUILD_FROM
# Build image is on Alpine because runtime image is on Alpine as well
FROM golang:1.15.7-alpine3.13 AS build

# Install dependencies
RUN apk add bash git make pkgconfig libsecret-dev gcc musl-dev

# Build
WORKDIR /build/
COPY build.sh /build/
RUN bash build.sh

# Runtime image provided by Home Assistant

FROM $BUILD_FROM

EXPOSE 25/tcp

# Set bash by default
SHELL ["/bin/bash", "-c"]

# Needed dependencies to run ProtonMail bridge
RUN apk add --no-cache \
    # To control ProtonMail bridge cli
    expect \
    # To bind any port
    socat \
    # Needed by ProtonMail bridge
    libsecret \
    # For PGP
    pass \   
    # For having nanoseconds resolution with date command
    coreutils \
    && rm -rf /var/cache/apk/*

COPY --from=build /build/proton-bridge/Desktop-Bridge /protonmail/proton-bridge
COPY gpgparams /protonmail/
COPY run.sh  /
COPY src/* /src/

RUN chmod +x /run.sh \
    && chmod +x /src/* \
    && ln -s /data/.cache /root/.cache \
    && ln -s /data/.gnupg /root/.gnupg \
    && ln -s /data/.password-store /root/.password-store \
    && ln -s /data/.config /root/.config

# Log timestamp format
ENV LOG_TIMESTAMP "%F %T.%3N"

ARG BUILD_ARCH
ARG BUILD_VERSION
LABEL io.hass.version="${BUILD_VERSION}" io.hass.type="addon" io.hass.arch="${BUILD_ARCH}" \
    maintainer="Florian Boulay" \
    org.opencontainers.image.authors="Florian Boulay" \
    org.opencontainers.image.version="${BUILD_VERSION}" \
    org.opencontainers.image.licenses="MIT"

ENTRYPOINT "bashio" "/run.sh" 
