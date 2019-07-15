#!/usr/bin/env bash

SRC=${1}
DEST=${2}

INCLUDE_SRC=
TARGET_HOST_NAME=
USER=
HOST=
PORT=22
USE_KEYS=true
KEY_PATH=
KEY_ARGS=""


# display help messages
function printHelp() {
	set -f
	echo "usage: ${SCRIPT_NAME} [[target_host_name:]src] [[target_host_name:]dest]"
	echo ""
	echo "---------------------"
	echo "valid arguments list"
	echo "---------------------"
	printf "%-15s %-20s\n" "[name]" "[description]"
	printf "%-15s %-20s\n" "local-vm1" "local vm server for fabric 192.168.10.15"
	echo ""
}

function printHelp() {
	set -f
	echo "usage: ${SCRIPT_NAME} [[target_host_name:]src] [[target_host_name:]dest]"
}


# parse name
function parseNameFromPath() {

	if [[ "${SRC}" == *":"* ]]; then
		INCLUDE_SRC=true
	elif [[ "${DEST}" == *":"* ]]; then
		INCLUDE_SRC=false
	else
		echo "Invalid args"
		exit 1
	fi

	if [[ "${INCLUDE_SRC}" = true ]]; then
		IFS=':' read -ra splits <<< "${SRC}"		
		TARGET_HOST_NAME=${splits[0]}
		SRC=${splits[1]}
	else 
		IFS=':' read -ra splits <<< "${DEST}"
		TARGET_HOST_NAME=${splits[0]}
		DEST=${splits[1]}
	fi
}

parseNameFromPath

case ${TARGET_HOST_NAME} in  
    --help)
        printHelp
        exit 0
        ;;
    local-vm1)
		USER="app"
        USE_KEYS=true
        KEY_PATH="/home/zaccoding/keys/local-vm.pem"
        HOST="192.168.79.130"
		;;
	*)
		echo "Cannot handle target host name : ${TARGET_HOST_NAME}"
		printHelp
		exit 1
		;;
esac

# check use keys or not
if [[ ${USE_KEYS} == true ]]; then
	KEY_ARGS="-i ${KEY_PATH}"
else
	KEY_ARGS=""
fi


if [[ "${INCLUDE_SRC}" = true ]]; then
	SRC=${USER}@${HOST}:${SRC}
else 
	DEST=${USER}@${HOST}:${DEST}
fi

echo "command :: scp -r ${KEY_ARGS} ${SRC} ${DEST}"
scp -r ${KEY_ARGS} ${SRC} ${DEST}
