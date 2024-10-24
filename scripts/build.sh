#!/usr/bin/env bash

IMAGE=queue-master

set -ev

SCRIPT_DIR=$(dirname "$0")
DOCKER_CMD=docker

if [[ -z "$GROUP" ]] ; then
    echo "Cannot find GROUP env var"
    exit 1
fi

if [[ -z "$TAG" ]] ; then
    echo "Cannot find TAG env var"
    exit 1
fi


CODE_DIR=$(cd $SCRIPT_DIR/..; pwd)
echo $CODE_DIR
$DOCKER_CMD run --rm -v $HOME/.m2:/root/.m2 -v $CODE_DIR:/usr/src/mymaven -w /usr/src/mymaven maven:3.5.2-jdk-8 mvn -DskipTests package

cp $CODE_DIR/target/*.jar $CODE_DIR/docker/$IMAGE

REPO=${GROUP}/$(basename $m)
$DOCKER_CMD build -t ${REPO}:${TAG} $CODE_DIR/docker/${IMAGE};
