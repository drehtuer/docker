#!/bin/bash

DST_BIN="${DST_DIR}/server_dst/bin/dontstarve_dedicated_server_nullrenderer"
DST_PID=""

function download {
    ${STEAMCMD_PATH}/steamcmd.sh +login anonymous +force_install ${DST_DIR} +app_update 343050 validate +quit
}

function update {
    kill ${DST_PID}
    DST_PID=""
    download
    sleep 10
    start
}

function start {
    ${DST_BIN} -console -cluster ${DST_CLUSTER} -shard ${DST_SHARD} -persistent_storage_root ${DST_STORAGE} &
    DST_PID="$!"
}

if [[ "$#" == "1" && "$1" == "update" ]]; then
    update
else
    [ ! -f ${DST_BIN} ] && download
    [ "$?" == "0" ]     && start
    tail -f ${DST_STORAGE}/${DST_CLUSTER}/${DST_SHARD}/server_log.txt
fi
