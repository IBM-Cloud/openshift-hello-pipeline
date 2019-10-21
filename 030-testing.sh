#!/bin/bash

# switch to testing
oc project testing

oc policy add-role-to-user edit system:serviceaccount:cicd:jenkins

# grab the latest from dev
oc tag development/hello-node-app:latest hello-node-app:test

# and create an app out of it
oc new-app --image-stream=hello-node-app:test

# make the test app visible
oc expose svc/hello-node-app
