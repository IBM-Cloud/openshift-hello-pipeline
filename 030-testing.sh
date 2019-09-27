#!/bin/bash

# switch to testing
oc project testing

# grab the latest from dev
oc tag development/hello-node-app:latest hello-node-app:test

# and create an app out of it
oc new-app --image-stream=hello-node-app:test

# make the test app visible
oc expose svc/hello-node-app

# ping the app
ROUTE=http://$(oc get route hello-node-app --template '{{.spec.host}}')
until curl $ROUTE > /dev/null 2>&1
do
  echo -n "."
  sleep 10
done
echo "App is ready at $ROUTE"
