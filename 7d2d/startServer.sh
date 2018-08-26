#!/usr/bin/env bash
BIN="7DaysToDieServer.x86_64"
LOG_FILE="log_$(date +"%Y%m%d_%H%M%S").txt"

# Make sure the file exists
touch ${LOG_FILE}

./${BIN} configfile=${SDTD_CONFIG} -logfile ${LOG_FILE} -quit -batchmode -nographics -dedicated 1>>${LOG_FILE} 2>&1 &

tail -f ${LOG_FILE}
