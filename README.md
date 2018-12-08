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
First install the dashboard by running
```
kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/master/src/deploy/recommended/kubernetes-dashboard.yaml
```
Then, we give admin access to the dashboard by running the below command in the ansible main directory. **(NOTE: This can cause a security hole!)**
```
kubectl create -f dashboard-admin.yaml
```
Now, we run the proxy as follows
```
kubectl proxy --address 0.0.0.0 --port=8001 --accept-hosts='.*' --kubeconfig=/root/.kube/config
```
Then you can go to the dashboard located in 
```
http://172.24.90.32:8001/api/v1/namespaces/kube-system/services/https:kubernetes-dashboard:/proxy/#!/overview?namespace=default
```

Here are the steps to get into the dashboard **only if you skipped giving the admin access!**.

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
