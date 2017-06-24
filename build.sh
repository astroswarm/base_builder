#!/usr/bin/env sh
set -e

ARCH=`uname -m`

echo "Detected architecture: $ARCH."

if [ $ARCH == "x86_64" ]; then
  BASE_IMAGE="debian:jessie"

#elif uname -m | grep "arm" > /dev/null; then
#  docker pull resin/rpi-raspbian:jessie-20170614
#  docker tag resin/rpi-raspbian:jessie-20170614 base:latest
else
  echo "Invalid architecture"
  exit 1
fi

echo "Setting version."
VERSION=`date +%Y%m%d`
echo "Version is $VERSION."

echo "Pulling $ARCH base image: $BASE_IMAGE"
docker pull $BASE_IMAGE

echo "Tagging base image."
docker tag $BASE_IMAGE astroswarm/base-$ARCH:$VERSION
docker tag $BASE_IMAGE astroswarm/base-$ARCH:latest

echo "Would you like to release this base image now (y/n)?"
read release
if [ $release == "y" ]; then
  echo "Pushing AstroSwarm base image."
  docker push astroswarm/base-$ARCH:$VERSION
  docker push astroswarm/base-$ARCH:latest
fi
