#!/bin/bash

oc new-project cicd

# add policy for project creation
oc adm policy add-cluster-role-to-user self-provisioner -z jenkins

# create a new app pointing to the repo with Jenkinsfile
oc new-app https://github.com/IBM-Cloud/hello-node-app-pipeline.git#project


