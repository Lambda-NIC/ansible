#!/usr/bin/env sh

export ETCD_VERSION=2.3.2
export K8S_VERSION=1.2.3

# Etc Daemon
docker run \
  -d \
  --net=host \
  --name etcd \
  quay.io/coreos/etcd:v${ETCD_VERSION} \
  --listen-client-urls=http://0.0.0.0:4001 \
  --advertise-client-urls=http://127.0.0.1:4001 \
  --data-dir=/var/etcd/data

# API Server
docker run \
  -d \
  --net=host \
  --name apiserver \
  gcr.io/google_containers/hyperkube-amd64:v${K8S_VERSION} \
  /hyperkube apiserver \
  --insecure-bind-address=0.0.0.0 \
  --insecure-port=8080 \
  --service-cluster-ip-range=172.16.254.0/24 \
  --etcd-servers=http://127.0.0.1:4001 \
  --allow-privileged=true \
  --v=2 \
  --logtostderr=true

# Controller Manager
docker run \
  -d \
  --net=host \
  --name controller-manager \
  gcr.io/google_containers/hyperkube-amd64:v${K8S_VERSION} \
  /hyperkube controller-manager \
  --master=http://127.0.0.1:8080 \
  --v=2 \
  --logtostderr=true

# Scheduler
docker run \
  -d \
  --net=host \
  --name scheduler \
  gcr.io/google_containers/hyperkube-amd64:v${K8S_VERSION} \
  /hyperkube scheduler \
  --master=http://127.0.0.1:8080 \
  --v=2 \
  --logtostderr=true


# Kubelet
docker run \
  -d \
  --privileged=true \
  --net=host \
  --pid=host \
  -v /:/rootfs:ro \
  -v /sys:/sys:ro \
  -v /dev:/dev \
  -v /var/lib/docker/:/var/lib/docker:rw \
  -v /var/lib/kubelet/:/var/lib/kubelet:rw \
  -v /var/run:/var/run:rw \
  --name kubelet \
  gcr.io/google_containers/hyperkube-amd64:v${K8S_VERSION} \
  /hyperkube kubelet \
  --containerized \
  --address=0.0.0.0 \
  --hostname-override=127.0.0.1 \
  --api-servers=http://127.0.0.1:8080 \
  --allow-privileged=true \
  --v=2 \
  --logtostderr=true

# Proxy
docker run \
  -d \
  --privileged=true \
  --net=host \
  --name proxy \
  gcr.io/google_containers/hyperkube-amd64:v${K8S_VERSION} \
  /hyperkube proxy \
  --master=http://127.0.0.1:8080 \
  --v=2 \
  --logtostderr=true


# Install kubectl
curl -L http://storage.googleapis.com/kubernetes-release/release/v${K8S_VERSION}/bin/linux/amd64/kubectl > /usr/local/bin/kubectl
chmod +x /usr/local/bin/kubectl
