# Ansible Playbook for getting OpenFaaS working

## Requirements
* Vagrant
* Virtualbox

## Steps to get OpenFaaS running

TODO: Clean this up into a single repo.

1. Run `vagrant up` to get the vm running
2. `vagrant ssh` to get into the vm.
3. Generate a ssh key and copy it to all of the machines.
4. Run `sudo pip install -r requirements.txt` **within kubespray** to get the requirements.
5. Check `kubespray/inventory/mycluster/hosts.ini` to see if the configuration is correct.
6. Run `setup.sh` **within kubespray** to get the Kubernetes cluster running.
7. Then come back to `ansible/testbed/stanford/` and run `setup_openfaas.sh`.
8. Go into the master machine and run `kubectl get pods --namespace openfaas` to see if it is running correctly!

DONE!

## Steps to clean up

1. Go to `ansible/testbed/stanford/` and run `cleanup_openfaas.sh`. 
2. Go to `kubespray` and run `cleanup.sh`.

