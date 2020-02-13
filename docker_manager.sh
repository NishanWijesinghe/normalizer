#!/usr/bin/env bash

export cmd=$1

export COMPONENT=normalizer
export environment_tag="latest"

export DOCKER_FILE=Dockerfile
export build_args=""

export DOCKER_OPTS=""
export DOCKER_ENV=""
export DOCKER_PORTS=""


build(){
    echo "docker build -t ${COMPONENT}:${environment_tag} --file ${DOCKER_FILE} . ${build_args}"
    docker build -t ${COMPONENT}:${environment_tag} --file ${DOCKER_FILE} . ${build_args}
}

run() {
    kill_local_containers
    echo "docker run --name ${COMPONENT} ${DOCKER_OPTS} ${DOCKER_ENV} ${DOCKER_PORTS} \
    ${COMPONENT}:${environment_tag}"

    docker run --name ${COMPONENT} ${DOCKER_OPTS} ${DOCKER_ENV} ${DOCKER_PORTS} \
    ${COMPONENT}:${environment_tag}
}

kill_local_containers() {
    docker stop ${COMPONENT}
    docker rm ${COMPONENT}
}

if [[ "$cmd" = 'build_run' ]]; then
    build && run
elif [[ "$cmd" = 'run' ]]; then
        run
else
    echo ""
    echo "$1 :INVALID COMMAND."
    exit 1
fi