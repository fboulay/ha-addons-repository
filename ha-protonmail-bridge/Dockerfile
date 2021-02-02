ARG BUILD_FROM

# Build image
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
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Needed dependencies to run ProtonMail bridge
RUN apk add --no-cache \
    expect \
    socat \
    libsecret \
    pass \
    && rm -rf /var/cache/apk/*

COPY --from=build /build/proton-bridge/Desktop-Bridge /protonmail/proton-bridge
COPY gpgparams /protonmail/
COPY run.sh /
COPY pmb-non-interactive.expect /
RUN chmod +x /run.sh
RUN chmod +x /pmb-non-interactive.expect
RUN ln -s /data/.cache /root/.cache
RUN ln -s /data/.gnupg /root/.gnupg
RUN ln -s /data/.password-store /root/.password-store
RUN ln -s /data/.config /root/.config


ENTRYPOINT "bashio" "/run.sh" 
