#!/usr/bin/env bash

export cmd=$1

export COMPONENT=normalizer
export environment_tag="latest"

export DOCKER_FILE=Dockerfile
export build_args=""

export test_host_path=$(pwd)/test/data/
export CONTAINER_PATH=/opt/$COMPONENT/inputs
export DOCKER_OPTS=" --privileged -itd -v $test_host_path:$CONTAINER_PATH "
export DOCKER_ENV=""
export DOCKER_PORTS=""

export REPO_URI=nishanwij/normalizer
export REPO_TAGGED=${REPO_URI}:${environment_tag}


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

create_container_outputs(){
    docker exec -it ${COMPONENT} bash -c "./normalize_docker_volume.sh"
}

copy_normalized_outputs_to_host(){
    docker exec -it ${COMPONENT} bash -c "./cp_to_host_volume.sh"
}

push() {
    docker_login
    tag
    docker push ${REPO_TAGGED}
    say "Push complete"
}

tag() {
    echo "Tagging ${COMPONENT}:${environment_tag} "
    echo "to ${REPO_TAGGED}"
    docker tag ${COMPONENT}:${environment_tag} ${REPO_TAGGED}
}

docker_login(){
  docker login --username=nishanwij
}

kill_local_containers() {
    docker stop ${COMPONENT}
    docker rm ${COMPONENT}
}

if [[ "$cmd" = 'build_run' ]]; then
    build && run
elif [[ "$cmd" = 'build' ]]; then
    build
elif [[ "$cmd" = 'run' ]]; then
    run
elif [[ "$cmd" = 'create_container_outputs' ]]; then
    create_container_outputs
elif [[ "$cmd" = 'copy_normalized_outputs_to_host' ]]; then
    copy_normalized_outputs_to_host
elif [[ "$cmd" = 'push' ]]; then
    push
else
    echo "$cmd"
fi