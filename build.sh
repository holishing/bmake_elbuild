#!/bin/sh
set -eux

docker build --no-cache -t tmp_img .
CONTAINER_ID=$(docker create tmp_img)
docker cp "$CONTAINER_ID":/root/rpmbuild/RPMS/noarch/mk-files-20180528-4.el8.noarch.rpm "$PWD"
docker cp "$CONTAINER_ID":/root/rpmbuild/RPMS/x86_64/bmake-20180512-4.el8.x86_64.rpm "$PWD"
docker rm "$CONTAINER_ID"
docker rmi tmp_img
