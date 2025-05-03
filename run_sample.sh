#!/usr/bin/env bash

# uncomment below line for avoiding python runtime error on MacOSX
#export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES

IMAGE="element/ansible:latest"

COMMAND="ansible-playbook -i inventory/all.yml -b playbook_sample.yml"
#COMMAND="sh"


docker build -t ${IMAGE} .

docker run \
    --name ansible \
    --rm \
    -it  \
    -v ${PWD}:/src \
    -w /src \
    ${IMAGE} \
    ${COMMAND}
