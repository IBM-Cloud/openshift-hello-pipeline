#!/bin/bash

RESPONSE=$(oc project testing 2>&1)
# switch to testing
if [[ $RESPONSE == *"does not exist"* ]]; then
  echo "Creating a new project"
  oc new-project testing
fi

# grab the latest from dev
oc tag development/hello-node-app:latest hello-node-app:test

# and create an app out of it
oc new-app --image-stream=hello-node-app:test -e ENVIRONMENT=testing

# make the test app visible
oc expose svc/hello-node-app

# ping the app
ROUTE=http://$(oc get route hello-node-app --template '{{.spec.host}}')
until curl -f $ROUTE > /dev/null 2>&1
do
  echo -n "."
  sleep 10
done
echo "App is ready at $ROUTE"
