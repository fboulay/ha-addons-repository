ARG BUILD_FROM
# Runtime image provided by Home Assistant
FROM $BUILD_FROM

# Build files
WORKDIR /build/
COPY build.sh /build/
# Runtime files
COPY gpgparams /protonmail/
COPY run.sh  /
COPY src/* /src/

RUN apk add --no-cache --virtual .build-dependencies \
    # build depenencies
    go=1.15.10-r0 \
    git=2.30.2-r0 \
    make=4.3-r0 \
    libsecret-dev=0.20.4-r0 \
    gcc=10.2.1_pre1-r3 \
    musl-dev=1.2.2-r0 \
    \
    # Run build script
    && bash build.sh \
    \
    ## Needed dependencies to run ProtonMail bridge ##
    && apk add --no-cache \
    # To control ProtonMail bridge cli
    expect=5.45.4-r0 \
    # To bind any port
    socat=1.7.4.1-r0 \
    # Needed by ProtonMail bridge
    libsecret=0.20.4-r0 \
    # For PGP
    pass=1.7.3-r3 \
    # For having nanoseconds resolution with date command
    coreutils=8.32-r2 \
    \ 
    # Keep built binary
    && cp /build/proton-bridge/Desktop-Bridge /protonmail/proton-bridge \
    \
    # Some links and rights needed
    && chmod +x /run.sh \
    && chmod +x /src/* \
    && ln -s /data/.cache /root/.cache \
    && ln -s /data/.gnupg /root/.gnupg \
    && ln -s /data/.password-store /root/.password-store \
    && ln -s /data/.config /root/.config \
    \
    # Remove build related files
    && go clean -cache -modcache -i -r \
    && apk del --no-cache --purge .build-dependencies \
    && rm -Rf /build /tmp/*

EXPOSE 25/tcp
WORKDIR /

# Set bash by default
SHELL ["/bin/bash", "-c"]

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
