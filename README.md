# Docker EPICS Archiver Appliances Composed

Docker compose files for epics archiver appliances containers.

### Changing subnet IPv4 addresses

Change each container's IP address, as decribed in `https://docs.docker.com/compose/compose-file/#ipam` and `https://github.com/docker/compose/issues/2582`.

### Executing `docker-compose.yml`

Clone and change your working directory to the project folder. Then, execute `docker-compose up -d` to deploy all containers and `docker-compose down` to stop them. 

### Setting `systemd` services up

Execute `make install` with `root` rights in order to copy all required files and start systemd service.
