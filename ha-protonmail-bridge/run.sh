#!/usr/bin/env bashio

bashio::log.info "Staring ProtonMail Bridge addon"

bashio::config.require.username
bashio::config.require.password

# Create directories we want to store in persistent directory
mkdir -p /data/.password-store
mkdir -p /data/.gnupg 
mkdir -p /data/.cache 
mkdir -p /data/.config 

chmod 700 /data/.gnupg
chmod 700 /data/.password-store

# socat will make the conn appear to come from 127.0.0.1
# ProtonMail Bridge currently expects that.
# It also allows us to bind to the real ports :)
socat TCP-LISTEN:25,fork TCP:127.0.0.1:1025 &
socat TCP-LISTEN:143,fork TCP:127.0.0.1:1143 &

# Disable exit on non-zero status, because expect script can return non-zero values
set +o errexit 

# Generate a PGP key if missing

if ! gpg --list-keys pass-key &> /dev/null; then
    bashio::log.info "First time launch - Generating a PGP key"
    gpg --no-options --generate-key --batch --no-tty /protonmail/gpgparams &> /dev/null
    pass init pass-key &> /dev/null
fi

# Check if the password is in the HaveIBeenPwned database
bashio::config.suggest.safe_password 'password'

# A new one is created if not connected to ProtonMail
/src/info.expect  > /dev/null
if [[ $? == 1 ]]; then
    bashio::log.info "Not connected - adding account to ProtonMail Bridge"
    set +o errexit 
    
    # Display error on add account
    if ! PMB_ADD_ACCOUNT=$(/src/add-account.expect "$(bashio::config 'username')" "$(bashio::config 'password')" "$(bashio::config 'two_factor_code')"); then
        bashio::log.error "${PMB_ADD_ACCOUNT}" 
    fi
fi

set +o errexit 
PMB_INFO=$(/src/info.expect) 
if [[ $? == 2 ]]; then
    set -o errexit 
    bashio::log.info "" 
    bashio::log.info "${PMB_INFO}"
    bashio::log.info ""
    bashio::log.info "Starting ProtonMail Bridge" 
    /protonmail/proton-bridge --noninteractive
else
    bashio::log.error "Cannot connect - Please check errors above"
fi
