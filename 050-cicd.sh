#!/bin/bash

oc project cicd

# add policy for project creation
oc adm policy add-cluster-role-to-user self-provisioner -z jenkins
oc policy add-role-to-user edit system:serviceaccount:cicd:jenkins -n development
oc policy add-role-to-user edit system:serviceaccount:cicd:jenkins -n testing
oc policy add-role-to-user edit system:serviceaccount:cicd:jenkins -n production

# create a new app pointing to the repo with Jenkinsfile
oc new-app https://github.com/IBM-Cloud/hello-node-app-pipeline.git#project
