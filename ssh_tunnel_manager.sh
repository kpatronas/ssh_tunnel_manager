#!/bin/bash

status_tunnel() {
    params="$@"
    params_title=`echo "$params" | tr ' ' '_'`
    if [ -S /tmp/.ssh-$params_title ]; then
        ssh -q -S /tmp/.ssh-$params_title -O check ssh-$params_title 2>&1 > /dev/null
        if [ ! $? -eq 0 ]; then
                echo `date`" - ERROR - COULD NOT CHECK TUNNEL - $params"
        else
                echo `date`" - INFO - TUNNEL CREATED - $params"
        fi
    else
        echo `date`" - WARNING - TUNNEL SOCKET - /tmp/.ssh-$params_title DOES NOT EXIST."
    fi
}

delete_tunnel() {
    params="$@"
    params_title=`echo "$params" | tr ' ' '_'`
    if [ -S /tmp/.ssh-$params_title ]; then
        ssh -q -S /tmp/.ssh-$params_title -O exit ssh-$params_title 2>&1 /dev/null
        if [ ! $? -eq 0 ]; then
                echo `date`" - ERROR - COULD NOT STOP TUNNEL - $params"
        else
                echo `date`" - INFO - TUNNEL STOPPED - $params"
        fi
    else
        echo `date`" - WARNING - TUNNEL SOCKET - /tmp/.ssh-$params_title DOES NOT EXIST."
    fi
}

create_tunnel() {

    params="$@"
    ssh_params="-N -o ConnectTimeout=15 -o ServerAliveInterval=60 -o ExitOnForwardFailure=yes"
    params_title=`echo "$params" | tr ' ' '_'`

    if [ ! -S /tmp/.ssh-$params_title ]; then
        ssh -q $ssh_params $params -S /tmp/.ssh-$params_title -M -fN ssh-$params_title 2>&1 > /dev/null
        if [ ! $? -eq 0 ]; then
                echo `date`" - ERROR - COULD NOT CREATE TUNNEL - $params"
        else
                echo `date`" - INFO - TUNNEL CREATED - $params"
        fi
    else
        echo `date`" - WARNING - COULD NOT CREATE TUNNEL - /tmp/.ssh-$params_title SOCKET EXIST."
    fi
}

export -f create_tunnel
export -f delete_tunnel
export -f status_tunnel

if [ "$#" -ne 2 ]; then
    echo "filename start|stop|status"
fi

if [ "$2" == "start" ]; then

    cat $1 | xargs -I {} -P8 bash -c 'create_tunnel {} ; true'
    exit
fi

if [ "$2" == "stop" ]; then
    cat $1 | xargs -I {} -P8 bash -c 'delete_tunnel {} ; true'
    exit
fi


if [ "$2" == "status" ]; then
    cat $1 | xargs -I {} -P8 bash -c 'status_tunnel {} | grep -vi master; true'
    exit
fi
