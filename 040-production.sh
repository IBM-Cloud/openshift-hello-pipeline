#!/bin/bash

# switch to production
oc project production

oc policy add-role-to-user edit system:serviceaccount:cicd:jenkins

# grab the latest from test
oc tag testing/hello-node-app:test hello-node-app:prod

# and create an app out of it
oc new-app --image-stream=hello-node-app:prod

# make the test app externally visible
oc expose svc/hello-node-app

sleep 20

# ping the app
echo "App is ready at"
oc get route hello-node-app --template '{{.spec.host}}'

