#!/usr/bin/env bashio

#
# debug.sh : this can be used to have an interactive menu and call all expect scripts in any order to debug them
#

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


set +o errexit 

while :
do
    echo ""
    echo "Menu"
    echo " i : info of current connected account"
    echo " c : connect to ProtonMail"
    echo " l : logout from ProtonMail"
    echo " e : exit this menu"
    read -r -p ">" c
	case $c in
        i) RET=$(/src/info.expect) 
            echo $?
            echo "$RET"
            ;;
        c) RET=$(/src/add-account.expect  "$(bashio::config 'username')" "$(bashio::config 'password')" "$(bashio::config 'two_factor_code')") 
            echo $?
            echo "$RET"
            ;;
        l) RET=$(/src/logout.expect) 
            echo $?
            echo "$RET"
            ;;
        e) break
            ;;
        *) echo "Select between i, c, l and e only"
	esac
done
