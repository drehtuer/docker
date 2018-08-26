#!/bin/sh

BIN="7DaysToDieServer.x86_64"

./${BIN} configfile=${1} -logfile ${2} -quit -batchmode -nographics -dedicated &

tail -f ${2}
