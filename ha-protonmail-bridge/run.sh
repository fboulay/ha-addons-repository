#!/usr/bin/env bashio

# Create directories we want to store in persistent directory
mkdir -p /data/.password-store
mkdir -p /data/.gnupg 2>/dev/null
mkdir -p /data/.cache 2>/dev/null
mkdir -p /data/.config 2>/dev/null

chmod 700 /data/.gnupg
chmod 700 /data/.password-store

# socat will make the conn appear to come from 127.0.0.1
# ProtonMail Bridge currently expects that.
# It also allows us to bind to the real ports :)
socat TCP-LISTEN:25,fork TCP:127.0.0.1:1025 &
socat TCP-LISTEN:143,fork TCP:127.0.0.1:1143 &

# A new one is created each time the container is starting. It does not seem to create any issue
gpg --no-options --generate-key --batch /protonmail/gpgparams
pass init pass-key

# Start protonmail
# Fake a terminal, so it does not quit because of EOF...
rm -f faketty
mkfifo faketty
cat faketty | /pmb-non-interactive.expect $(bashio::config 'username') $(bashio::config 'password') $(bashio::config 'two_factor_code')
