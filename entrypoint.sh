#!/bin/bash

set -e

CHECKOUT="${1:-}"
DESTINATION="${2:-.}"

if [[ "$(ls -Uba1 | wc -l)" -le 2 ]]; then
  echo "Cloning s3fs-fuse repository"
  git clone -q -- https://github.com/s3fs-fuse/s3fs-fuse.git /code
  if [[ -n "${CHECKOUT}" ]]; then
    echo "Checking out ${CHECKOUT}"
    git checkout -q "${CHECKOUT}"
  fi
fi

./autogen.sh >/dev/null
./configure >/dev/null
make --quiet

if [[ -d "${DESTINATION}" ]]; then
  DESTFILE="${DESTINATION}/s3fs-$(git describe --dirty --tags)-$(lsb_release -sc)"
  echo "Result in $(readlink -f ${DESTFILE})"
  cp -- src/s3fs "${DESTFILE}"
fi
