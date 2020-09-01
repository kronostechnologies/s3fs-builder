#!/bin/bash

CHECKOUT="${1:-master}"

docker build -f Dockerfile-stretch -t s3fs-builder:stretch .
docker build -f Dockerfile-buster -t s3fs-builder:buster .

mkdir -p bin

docker run -it --rm --name s3fs-stretch -v "$(pwd)/bin":/dist -- s3fs-builder:stretch "${CHECKOUT}" "/dist"
docker run -it --rm --name s3fs-buster -v "$(pwd)/bin":/dist -- s3fs-builder:buster "${CHECKOUT}" "/dist"
