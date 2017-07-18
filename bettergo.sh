#!/bin/bash

USER=tmpuser

# Add an entry to /etc/passwd
if [ $UID -ne 0 ]; then
    DAYS=`expr $(date +%s) / 86400`
    echo "$USER:x:$UID:${GID:-$UID}::/:/bin/bash" >> /etc/passwd
    echo "$USER:!:$DAYS::::::" >> /etc/shadow
fi

echo $CGO_ENABLED

# Ensure /go is owned by the user
chown -R $UID:$UID /go

# Switch to the specified user's account and run the command
sudo -Eu $USER env "PATH=$PATH" "$@"
