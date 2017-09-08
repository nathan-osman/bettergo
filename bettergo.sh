#!/bin/bash

USER=tmpuser

# Create a new group and user with the correct values
groupadd -g $GID $USER
useradd -mu $UID -g $GID $USER

# Ensure /go is owned by the user
chown -R $UID:$UID /go

# Switch to the specified user's account and run the command
sudo -EHu $USER env "PATH=$PATH" "$@"
