ARG BUILD_FROM
# Build image is on Alpine because runtime image is on Alpine as well
FROM golang:1.15.7-alpine3.13 AS build

# Install dependencies
RUN apk add --no-cache \
    bash=5.1.0-r0 \
    git=2.30.1-r0 \
    make=4.3-r0 \
    libsecret-dev=0.20.4-r0 \
    gcc=10.2.1_pre1-r3 \
    musl-dev=1.2.2-r0

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
    expect=5.45.4-r0 \
    # To bind any port
    socat=1.7.4.1-r0 \
    # Needed by ProtonMail bridge
    libsecret=0.20.4-r0 \
    # For PGP
    pass=1.7.3-r3 \
    # For having nanoseconds resolution with date command
    coreutils=8.32-r2

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

CMD ["bashio", "/run.sh"]
