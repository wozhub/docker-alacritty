#!/bin/bash

# This script uses a docker container to build alacritty from sources,
# saves the built binary to a small Alpine container, copies the binary
# to /usr/local/bin, and removes the saved Docker image.  
#
# Why is this helpful?  Alacritty is not packaged for Raspberry Pi OS! 
# And this build process doesn't require the installation of build-
# related packages on your Raspberry Pi.

set -eo pipefail

if [ "$USER" != "root" ]; then
  echo "ERROR:  You must run $0 as user root."
  exit 1
fi

if ! which docker >/dev/null 2>&1; then
  echo "Cannot locate 'docker' in user root's path."
  exit 1
fi

docker build -t alacritty-alpine .
docker stop alacritty 2>/dev/null || true
docker run -d --rm --name alacritty alacritty-alpine sh -c 'while true; do sleep 2; date; done'
docker cp alacritty:/alacritty /usr/local/bin/
docker stop alacritty
docker rmi alacritty-alpine

echo -e "\n\nAlacritty installed to /usr/local/bin/alacritty."
