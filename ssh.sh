#!/usr/bin/env bash

SCRIPT_NAME=ssh.sh
TARGET_HOST_NAME=$1
USER=""
HOST=""
PORT=22
USE_KEYS=true
KEY_PATH=""

function printHelp() {
	set -f
	echo "usage: ${SCRIPT_NAME} <name>"
	echo ""
	echo "---------------------"
	echo "valid arguments list"
	echo "---------------------"
	printf "%-15s %-20s\n" "[name]" "[description]"
	printf "%-15s %-20s\n" "local-fabric1" "local vm server for fabric 192.168.10.15"
	echo ""
}

function displayHelpTarget {
  printf "%-15s %-20s\n" ${1} ${2}
}


if [[ -z ${TARGET_HOST_NAME} ]]; then
	echo "invalid target host name : ${TARGET_HOST_NAME}"
	echo ""
	printHelp
	exit 1
fi	


case ${TARGET_HOST_NAME} in 
	--help)
		printHelp
		exit 0
		;;
	local-fabric1)
		USER="app"
		USE_KEYS=false
		HOST="192.168.10.15"
		;;
	*)
		echo "Cannot handle target host name : ${TARGET_HOST_NAME}"
		exit 1
		;;		
esac			


# ssh execute
if [[ "${USE_KEYS}" == "true" ]]; then
	echo "command :: ssh -i ${KEY_PATH} ${USER}@${HOST} -p ${PORT}"
	sudo ssh -i ${KEY_PATH} ${USER}@${HOST} -p ${PORT}
else
	echo "command : ssh ${USER}@${HOST} -p ${PORT}"
	sudo ssh ${USER}@${HOST} -p ${PORT}
fi
