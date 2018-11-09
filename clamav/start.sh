#!/usr/bin/env bash

CLAMD="clamd"
FRESHCLAM="freshclam"
USER="clamav"
GROUP="clamav"
CLAM_DB="/var/lib/clamav"
CLAM_SOCKET="/var/run/clamav"
CLAM_MAIN="main.cvd"
STATUS=0

function stopClamAV {
	trap "" SIGINT
	echo "Killing freshclam"
	kill -0 ${PID_FC}
	STATUS=$((${STATUS} | ${?}))
	echo "Killing clamd"
	kill -0 ${PID_CD}
	STATUS=$((${STATUS} | ${?}))
}

function initClamAV {
	if [ ! -e ${CLAM_DB}/${CLAM_MAIN} ]; then
		echo "Initial av database download"
		chown -R ${USER}:${GROUP} ${CLAM_DB}
		chown -R ${USER}:${GROUP} ${CLAM_SOCKET}
		${FRESHCLAM}
	fi
}

function startClamAV {
	${FRESHCLAM} -d &
	PID_FC=${!}
	echo "Started freshclam with PID ${PID_FC}"
	
	${CLAMD} &
	PID_CD=${!}
	echo "Started clamd with PID ${PID_CD}"

	echo "Waiting for SIGINT ..."
	trap stopClamAV SIGINT
	wait -n
	STATUS=$((${STATUS} | ${?}))

	echo "Done waiting"

	# Terminate if it doesn't help
	kill ${PID_FC} ${PID_CD} 2>/dev/null
}

initClamAV
startClamAV

echo "Exiting"

exit ${STATUS}
