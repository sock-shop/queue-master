#!/usr/bin/env bash

set -ev

SCRIPT_DIR=$(dirname "$0")
DOCKER_CMD=docker

CODE_DIR=$(cd $SCRIPT_DIR/..; pwd)
echo $CODE_DIR

if [[ -z "$COVERALLS_TOKEN" ]] ; then
    echo "Unit Test without coverage"
    $DOCKER_CMD run --rm \
    -v $HOME/.m2:/root/.m2 \
    -v $CODE_DIR:/usr/src/mymaven \
    -w /usr/src/mymaven \
    maven:3.5.2-jdk-8 mvn test
else
    $DOCKER_CMD run --rm \
    -v $HOME/.m2:/root/.m2 \
    -v $CODE_DIR:/usr/src/mymaven \
    -w /usr/src/mymaven \
    maven:3.5.2-jdk-8 \
    mvn -DrepoToken=$COVERALLS_TOKEN verify jacoco:report coveralls:report
fi


