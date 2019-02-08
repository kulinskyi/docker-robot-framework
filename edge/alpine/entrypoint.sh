#!/bin/sh

set -e

FILE="./tests/requirements.txt"

if [ -f ${FILE} ]; then
    pip install -r ${FILE}
fi

robot ${ROBOT_OPTIONS} --outputDir ./output ./tests