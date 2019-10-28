#!/bin/bash

APP_REPOSITORY=$1
if [ -z "$APP_REPOSITORY" ]; then
  APP_REPOSITORY="https://github.com/IBM-Cloud/openshift-hello-app.git"
  echo "App repository not set, using the default"
fi
echo "App repository is set to $APP_REPOSITORY"

# switch to development project
oc project development

# allow other projects to pull the image from development builds
oc policy add-role-to-group system:image-puller system:serviceaccounts:production
oc policy add-role-to-group system:image-puller system:serviceaccounts:testing

# new app in dev
oc new-app "$APP_REPOSITORY" --name hello-node-app -e ENVIRONMENT=development

# expose the app
oc expose svc hello-node-app

# ping the app
ROUTE=http://$(oc get route hello-node-app --template '{{.spec.host}}')
until curl -f $ROUTE > /dev/null 2>&1
do
  echo -n "."
  sleep 10
done
echo "App is ready at $ROUTE"
