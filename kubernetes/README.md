# Kubernetes POD and SERVICE files

Kubernetes configuration files for the EPICS Archiver Appliance.

## Running

In order to launch PODs and SERVICEs, execute `./kubectl-appliances.sh create pod` or `./kubectl-appliances.sh create service`. Assure that kubernets systemd files are up.

To clean evertyhing up, execute `./kubectl-appliances.sh del pod` and `./kubectl-appliances.sh del service`.
