#!/bin/bash

# switch to development project
oc project development

# allow other projects to pull the image from development builds
oc policy add-role-to-group system:image-puller system:serviceaccounts:production
oc policy add-role-to-group system:image-puller system:serviceaccounts:testing
oc policy add-role-to-user edit system:serviceaccount:cicd:jenkins

# new app in dev
oc new-app https://github.com/IBM-Cloud/hello-node-app.git

# expose the app
oc expose svc hello-node-app

sleep 20

# ping the app
echo "App is ready at "
oc get route hello-node-app --template '{{.spec.host}}')

