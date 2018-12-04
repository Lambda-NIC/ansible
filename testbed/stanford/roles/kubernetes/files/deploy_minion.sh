#!/usr/bin/env sh

export K8S_VERSION=1.2.3

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
  --enable-server \
  --address=0.0.0.0 \
  --hostname-override=$1 \
  --api-servers=http://$2:8080 \
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
  --master=http://$2:8080 \
  --v=2 \
  --logtostderr=true

