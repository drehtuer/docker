#!/usr/bin/env bash
BIN="7DaysToDieServer.x86_64"

./${BIN} configfile=${SDTD_CONFIG} -logfile /dev/stdout -quit -batchmode -nographics -dedicated &
PID=$!
wait "${PID}"
