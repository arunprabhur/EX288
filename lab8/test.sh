#!/bin/bash

echo "Starting script"

function graceful_shutdown(){
	echo "Graceful shutdown"
	FLAG=0
	exit 0
}

FLAG=1
sleep 1
ARG=$1

trap graceful_shutdown  SIGINT SIGTERM

while [ ${FLAG} -eq 1 ]
do
	echo "Hello ${1} -- ${2}"
	echo "from test.sh: $(date)" >log.txt
	sleep 10
done
