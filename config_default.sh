#!/bin/sh
#Generate config for node
config_node_file="Dogenano/config-node.toml"
ip=$(curl -s https://ipinfo.io/ip)
if [ ! -f $config_node_file ]
then
    echo "Creating node config" $config_node_file
    node_config=$(./dogenano_node_linux --generate_config node)
    node_config=$(echo "$node_config" | sed "s/\[rpc\]/[rpc]\n\nenable = true/g")
    node_config=$(echo "$node_config" | sed "s/\#external_address\ \= \"\:\:\"/external_address = \"::ffff:${ip}\"/g")
    node_config=$(echo "$node_config" | sed "s/\#external_port\ \= 0/external_port = 7045/g")
    node_config=$(echo "$node_config" | sed "s/\#enable_voting\ \=\ false/enable_voting = true/g")
    #node_config=$(echo "$node_config" | sed "s/\#vote_minimum\ \=\ \"1000000000000000000000000000000000\"/vote_minimum = \"1000000000000000000000000000000000\"/g")
    echo "$node_config" > $config_node_file
fi

#Generate config for rpc
rpc_node_file="Dogenano/config-rpc.toml"
if [ ! -f $rpc_node_file ]
then
    echo "Creating rpc config" $rpc_node_file
    rpc_config=$(./dogenano_node_linux --generate_config rpc)
    rpc_config=$(echo "$rpc_config" | sed "s/\#address\ \=\ \"::1\"/address = \"::ffff:0.0.0.0\"/g")
    rpc_config=$(echo "$rpc_config" | sed "s/\#enable_control\ \=\ false/enable_control = true/g")
    rpc_config=$(echo "$rpc_config" | sed "s/\#max_json_depth\ \=\ 20/max_json_depth = 20/g")
    rpc_config=$(echo "$rpc_config" | sed "s/\#max_request_size\ \=\ 33554432/max_request_size = 33554432/g")
    rpc_config=$(echo "$rpc_config" | sed "s/\#port\ \=\ 45000/port = 9999/g")
    echo "$rpc_config" > $rpc_node_file
fi

#end of script 
