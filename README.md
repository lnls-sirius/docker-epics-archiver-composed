# Docker EPICS Archiver Appliances Composed

Docker compose files for epics archiver appliances containers.

## Deployment with Docker Compose

### Environment file

Define the environment variables in `lnls-epics-archiver.env` to set any EPICS preferences up. `CERTIFICATE_PASSWORD`, `CONNECTION_NAME` and `CONNECTION_PASSWORD` need to be changed to reflect the 
certificate password and LDAP binding address and password, respectively. Edit `docker-compose.yml` with its right location.

### Persistent data folders

Edit `docker-compose.yml` replacing all persistent data locations in all `volume` sections.

### Changing subnet IPv4 addresses

Change each container's IP address, as decribed in `https://docs.docker.com/compose/compose-file/#ipam` and `https://github.com/docker/compose/issues/2582`.

### Executing `docker-compose.yml`

Clone and change your working directory to the project folder. Then, execute `docker-compose up -d` to deploy all containers and `docker-compose down` to stop them. 

### Setting `systemd` services up

Execute `make install` with `root` rights in order to copy all required files and start systemd service.

## Deployment with Docker Swarm

Enter `swarm/` directory and execute `deploy-services.sh start` to deploy the services into the swarm and `deploy-services.sh stop` to shut them down.
