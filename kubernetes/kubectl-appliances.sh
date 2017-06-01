#!/bin/bash

function delete {

	for CONTAINER in ${CONTAINERS[@]}; do

		kubectl delete ${1} epics-archiver-${CONTAINER}-${1}

	done

}

function create	{

        for CONTAINER in ${CONTAINERS[@]}; do

                kubectl	create -f epics-archiver-${CONTAINER}-${1}.yaml

        done

}


ACTION=${1}
ENTITY=${2}

CONTAINERS=( "mysql-db" "mgmt" "engine" "retrieval" "etl" )

if [ "${ACTION}" == "del" ]; then

	delete ${ENTITY}
else
	create ${ENTITY}	

fi

kubectl get ${ENTITY}
