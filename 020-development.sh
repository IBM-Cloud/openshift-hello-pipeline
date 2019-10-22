#!/bin/bash

# switch to development project
oc project development

# allow other projects to pull the image from development builds
oc policy add-role-to-group system:image-puller system:serviceaccounts:production
oc policy add-role-to-group system:image-puller system:serviceaccounts:testing
oc policy add-role-to-user edit system:serviceaccount:cicd:jenkins

# new app in dev
oc new-app https://github.com/IBM-Cloud/hello-node-app.git --allow-missing-images

# expose the app
oc expose svc hello-node-app

# ping the app
ROUTE=http://$(oc get route hello-node-app --template '{{.spec.host}}')
until curl $ROUTE > /dev/null 2>&1
do
  echo -n "."
  sleep 10
done
echo "App is ready at $ROUTE"