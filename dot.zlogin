#!/bin/bash

AGENT="${HOME}/.ssh/ssh-agent-`hostname`"
if [ ! -d ${HOME}/.ssh ]; then
    mkdir -p ${HOME}/.ssh
fi
if [ ! -r ${AGENT} ]; then
    if [ x${SSH_AUTH_SOCK} != x -a "${SSH_AUTH_SOCK}" != "${AGENT}" ]; then
        ln -fs ${SSH_AUTH_SOCK} ${AGENT}
    fi
fi
export SSH_AUTH_SOCK=${AGENT}

#exec screen -xRU
#if [ ! "$WINDOW" ]; then
#  screen -U -D -RR
#fi

