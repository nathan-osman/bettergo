FROM golang:latest
MAINTAINER Nathan Osman <nathan@quickmediasolutions.com>

# sudo is required for switching users
RUN \
    apt-get update && \
    apt-get install -y sudo && \
    rm -rf /var/lib/apt/lists/*

# Add the bettergo.sh script
ADD bettergo.sh /usr/local/bin/

# Set the default entrypoint
ENTRYPOINT ["/usr/local/bin/bettergo.sh"]
