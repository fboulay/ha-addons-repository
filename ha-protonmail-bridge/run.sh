#!/usr/bin/env bashio

#source src/lib.trap.sh

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

rm -f faketty
mkfifo faketty


# Disable exit on non-zero status, because expect script can return non-zero values
set +o errexit 

# A new one is created if not connected to ProtonMail
PMB_CONNECTED=$(/src/info.expect)

if [[ $? == 1 ]]; then
    set -o errexit 
    echo "Not connected - generating a PGP key"
    gpg --no-options --generate-key --batch --no-tty /protonmail/gpgparams &> /dev/null
    pass init pass-key &> /dev/null
    
    set +o errexit 
    echo "Not connected - adding account to ProtonMail Bridge"
    PMB_ADD_ACCOUNT=$(/src/add-account.expect $(bashio::config 'username') $(bashio::config 'password') $(bashio::config 'two_factor_code')) 

    # Display error on add account
    if [[ $? != 0 ]]; then
        echo -e "${PMB_ADD_ACCOUNT}" 
    fi
fi

set -o errexit 
PMB_INFO=$(/src/info.expect) 
if [[ $? == 2 ]]; then
    set +o errexit 
    echo -e " \n" 
    echo -e "${PMB_INFO}"
    echo -e " \n"
    echo "Starting ProtonMail Bridge" 
    /protonmail/proton-bridge --noninteractive
else
    >&2 echo "Cannot connect - Please check errors above"
fi
