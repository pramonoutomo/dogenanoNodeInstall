#!/bin/sh

if pkill -9 dogenano_node_linux > dogenano.log 2>&1; then
./dogenano_node_linux --daemon
fi
exit
