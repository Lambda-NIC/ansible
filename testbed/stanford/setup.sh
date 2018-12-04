#!/usr/bin/env bash

ansible-playbook kubernetes.yml --tags install_common
ansible-playbook kubernetes.yml --tags create_cluster

ansible-playbook kubernetes.yml --tags create_apps