#!/bin/bash
set -e

mkdir -p /var/lib/rabbitmq

if [ "$ERLANG_COOKIE" ]; then
    cookieFile='/var/lib/rabbitmq/.erlang.cookie'
    if [ -e "$cookieFile" ]; then
        if [ "$(cat "$cookieFile" 2>/dev/null)" != "$ERLANG_COOKIE" ]; then
            echo >&2
            echo >&2 "warning: $cookieFile contents do not match ERLANG_COOKIE"
            echo >&2
        fi
    else
        echo "$ERLANG_COOKIE" > "$cookieFile"
        chmod 600 "$cookieFile"
        chown rabbitmq "$cookieFile"
    fi
fi

export HOSTNAME=$(hostname -f)

if [ ! -z $CLUSTER_WITH -a "$CLUSTER_WITH" == "$HOSTNAME" ]; then
  unset CLUSTER_WITH
fi;

chown rabbitmq:rabbitmq /var/lib/rabbitmq
exec gosu rabbitmq ./docker-entrypoint.sh "$@"
