#!/bin/bash

DST_BIN="${DST_DIR}/server_dst/bin/dontstarve_dedicated_server_nullrenderer"
DST_PID=""
DST_LOG=${DST_STORAGE}/${DST_CLUSTER}/${DST_SHARD}/server_log.txt

function download {
    echo "steamcmd update" >> ${DST_LOG}
    ${STEAMCMD_DIR}/steamcmd.sh +login anonymous +force_install ${DST_DIR} +app_update 343050 validate +quit 1 1>>${DST_LOG} 2>&1
}

function update {
    echo "Running daily update" >> ${DST_LOG}
    kill ${DST_PID}
    DST_PID=""
    download
    sleep 10
    start
}

function start {
    echo "Starting server" >> ${DST_LOG}
    ${DST_BIN} -console -cluster ${DST_CLUSTER} -shard ${DST_SHARD} -persistent_storage_root ${DST_STORAGE} &
    DST_PID="$!"
}

if [[ "$#" == "1" && "$1" == "update" ]]; then
    update
else
    touch ${DST_LOG}
    [ ! -f ${DST_BIN} ] && download
    [ "$?" == "0" ]     && start
    tail -f ${DST_LOG}
fi
