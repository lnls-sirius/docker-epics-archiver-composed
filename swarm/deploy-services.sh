#!/bin/bash

DOCKER_TAG=latest

NETWORK=epics-archiver-network
NETWORK_SUBNET=192.168.5.0/24

APPLIANCES=("mgmt" "engine" "etl" "retrieval")
PORTS=("11995" "11996" "11997" "11998")

SOURCE=/storage/epics-archiver
TARGET=/opt/epics-archiver-appliances

ENV_FILE=/home/srv1/repository/docker-epics-archiver-composed/lnls-epics-archiver.env

function start {



	docker network inspect ${NETWORK} &> /dev/null && exit 0

	docker network create --driver overlay --subnet ${NETWORK_SUBNET} --attachable ${NETWORK}

	docker service create --name epics-archiver-mysql-db \
                              --network	${NETWORK} \
                              --mount type=bind,source=/storage/epics-archiver/db,destination=/var/lib/mysql \
			      --env MYSQL_ROOT_PASSWORD=controle \
                              --env MYSQL_USER=lnls_user \
                              --env MYSQL_PASSWORD=controle \
                              --env MYSQL_PASSWORD=controle \
			      --detach \
                              lnlscon/epics-archiver-mysql-db


	i=0
	while [ $i -lt 4 ] ; do

		docker service create --name epics-archiver-${APPLIANCES[$i]} \
				      --publish ${PORTS[$i]}:${PORTS[$i]} \
				      --network ${NETWORK} \
				      --mount type=bind,source=${SOURCE}/storage/sts,destination=${TARGET}/storage/sts \
 				      --mount type=bind,source=${SOURCE}/storage/mts,destination=${TARGET}/storage/mts \
                                      --mount type=bind,source=${SOURCE}/storage/lts,destination=${TARGET}/storage/lts \
				      --mount type=bind,source=${SOURCE}/configuration,destination=${TARGET}/configuration \
				      --env-file ${ENV_FILE} \
				      --detach \
				      lnlscon/epics-archiver-${APPLIANCES[$i]}:${DOCKER_TAG}

		(( i++ ))
	done
}

function stop {

	docker network inspect ${NETWORK} &> /dev/null || exit 0

	docker service rm epics-archiver-mysql-db

        i=0
        while [ $i -lt 4 ] ; do

                docker service rm epics-archiver-${APPLIANCES[$i]}
                (( i++ ))
        done

        docker network rm ${NETWORK}

}

case $1 in

	start)
		start
	;;
	stop)
		stop
	;;
	restart)
		stop
		start
	;;
esac
