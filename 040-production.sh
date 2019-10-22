#!/bin/bash

# switch to production
oc project production

# grab the latest from test
oc tag testing/hello-node-app:test hello-node-app:prod

# and create an app out of it
oc new-app --image-stream=hello-node-app:prod

# make the test app externally visible
oc expose svc/hello-node-app

# ping the app
ROUTE=http://$(oc get route hello-node-app --template '{{.spec.host}}')
until curl -f $ROUTE > /dev/null 2>&1
do
  echo -n "."
  sleep 10
done
echo "App is ready at $ROUTE"
