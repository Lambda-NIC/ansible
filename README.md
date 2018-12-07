# Ansible Playbook for Installing OpenFaaS on Your Cluster

## Requirements
* Vagrant
* Virtualbox

These can be easily installed in Ubuntu via
```
sudo apt-get install virtualbox
sudo apt-get install vagrant
```
for other distributions, please refer to your own distribution manual.

## Steps to get OpenFaaS running

TODO: Clean this up into a single repo.

1. Run `vagrant up` to get the vm running
2. `vagrant ssh` to get into the vm.
3. Generate a ssh key and copy it to all of the machines.
4. Run `sudo pip install -r requirements.txt` **within kubespray** to get the requirements.
5. Check `kubespray/inventory/mycluster/hosts.ini` to see if the configuration is correct.
6. Run `setup.sh` **within kubespray** to get the Kubernetes cluster running.
7. Make sure to set your login credentials in `/vagrant/testbed/stanford/inventory.ini`.
8. Then come back to `ansible/testbed/stanford/` and run `setup_openfaas.sh`.
9. Go into the master machine and run `kubectl get pods --namespace openfaas` to see if it is running correctly!

DONE!

## Steps to clean up

1. Go to `ansible/testbed/stanford/` and run `cleanup_openfaas.sh`. 
2. Go to `kubespray` and run `cleanup.sh`.

## Steps to get into Kubernetes dashboard
Kubernetes dashboard is a tool where you can view the current status of the nodes, namespaces and pods.
It is located in http://<master-ip>:6443. Here are the steps to get into the dashboard.

1. If you are running fresh install of Kubespray, you need to add service account and clusterrolebinding as follows.
  ```
  $ kubectl create serviceaccount dashboard -n default
  $ kubectl create clusterrolebinding dashboard-admin -n default \
    --clusterrole=cluster-admin \
    --serviceaccount=default:dashboard
  ```
2. In order to log in, you need to know the token. Retrieve the token as follows.
  ```
  $ kubectl get secret $(kubectl get serviceaccount dashboard -o jsonpath="{.secrets[0].name}") -o jsonpath="{.data.token}" | base64 --decode
  ```
3. Copy & paste the token and you are in!

## Steps to get into the OpenFaaS main page
OpenFaaS main page lets you launch custom functions. Simply go into `http://<master-ip>:31119` and start launching!

## Steps to get into the Prometheus page
Prometheus is a tool to view current cluster statistics. Simply go into `http://<master-ip>:31119` and start analyzing!
