#!/bin/bash

function get_status() {
    local status="success"

    while read line; do
        if [[ $line == *"ERROR"* ]]; then
            status="waiting..."
        fi
    done
    echo $status
}

function print_instruction() {
    local ipv6addr="::"
    
    while read line; do
        if [[ $line == *"Husarnet IP address:"* ]]; then
            ipv6addr=${line#*"Husarnet IP address: "}
        fi
    done
    
    echo "*******************************************"
    echo "💡 Tip"
    echo "To SSH your container execute in a new terminal session:"
    echo ""
    echo "ssh johny@${ipv6addr}"
    echo ""
    echo "(default password is \"johny\" as well)"
    echo "*******************************************"
    echo ""
}

if [[ ${JOINCODE} == "" ]]; then
    echo ""
    echo "ERROR: No JOINCODE provided in \"docker run ... \" command. Visit app.husarnet.com to get a JOINCODE"
    echo ""
    /bin/bash
    exit
fi

echo ""
echo "⏳ [1/2] Initializing Husarnet Client:"
husarnet daemon > /dev/null 2>&1 &

for i in {1..10}
do
    sleep 1
    
    output=$( get_status < <(husarnet status) )
    echo "$output"
    
    if [[ $output != "waiting..." ]]; then
        break
    fi
done

echo ""
echo "🔥 [2/2] Connecting to Husarnet network as \"${HOSTNAME}\":"
husarnet join ${JOINCODE} ${HOSTNAME}
echo "done"
echo ""

print_instruction < <(husarnet status)

/usr/bin/firefox

/bin/bash