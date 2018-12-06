#!/usr/bin/env bash

# removes kubernetes dashboard
#ansible-playbook kubernetes.yml --tags destroy_apps

ansible-playbook kubernetes.yml --tags destroy_cluster
ansible-playbook kubernetes.yml --tags remove_common
