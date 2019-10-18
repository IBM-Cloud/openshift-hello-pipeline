#!/bin/bash
# create a new project
oc new-project cicd

# create a new app pointing to the repo with Jenkinsfile
oc new-app https://github.com/IBM-Cloud/hello-node-app-pipeline.git

# add policies allowing access to other projects
oc policy add-role-to-user edit system:serviceaccount:cicd:jenkins -n development
oc policy add-role-to-user edit system:serviceaccount:cicd:jenkins -n testing
oc policy add-role-to-user edit system:serviceaccount:cicd:jenkins -n production