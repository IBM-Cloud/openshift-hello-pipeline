#!/bin/bash
# create a new project
oc new-project cicd

# add policy for project creation
oc adm policy add-cluster-role-to-user self-provisioner -z jenkins

# create a new app pointing to the repo with Jenkinsfile
oc new-app https://github.com/IBM-Cloud/hello-node-app-pipeline.git

# add policies allowing access to other projects
oc policy add-role-to-user edit system:serviceaccount:cicd:jenkins -n development
oc policy add-role-to-user edit system:serviceaccount:cicd:jenkins -n testing
oc policy add-role-to-user edit system:serviceaccount:cicd:jenkins -n production
