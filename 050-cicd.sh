#!/bin/bash

PIPELINE_REPOSITORY=$1
if [ -z "$PIPELINE_REPOSITORY" ]; then
  PIPELINE_REPOSITORY="https://github.com/IBM-Cloud/openshift-hello-pipeline.git"
  echo "Pipeline repository not set, using the default"
fi
echo "Pipeline repository is set to $PIPELINE_REPOSITORY"

# create a new project
oc new-project cicd

# add policies allowing access to other projects
oc policy add-role-to-user edit system:serviceaccount:cicd:jenkins -n development
oc policy add-role-to-user edit system:serviceaccount:cicd:jenkins -n testing
oc policy add-role-to-user edit system:serviceaccount:cicd:jenkins -n production

# create a new app pointing to the repo with Jenkinsfile
oc new-app "$PIPELINE_REPOSITORY" --name hello-pipeline
