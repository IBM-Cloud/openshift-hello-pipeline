# Multiple environment(dev/test/prod) app deployment with Jenkins Pipeline

## Prerequisites

- Red Hat OpenShift on IBM Cloud cluster
- OpenShift CLI

> **Note:** The scripts use the hello-node-app from a [Git repo](https://github.com/IBM-Cloud/openshift-hello-app)

## Deploy a node app to Dev/Test/Prod

1. Clone this repo to your machine
2. Log into your OpenShift cluster
3. Run the scripts(follow the numbering) on a terminal to create projects(development/testing/production) and also deploy the app
   ```
   ./010-create-projects.sh
   ./020-development.sh
   ./030-testing.sh
   ./040-production.sh
   ```
4. Once the script is executed, run the below command to check the status of the deployment in `development`
    ```
    oc status -n development
    ```
5. Once the deployment is successful, run the below command to see 'Hello World' in the output
    ```
    curl $(oc get route hello-node-app --template '{{.spec.host}}/')
    ```
## Create a Jenkins pipeline

1. Run the below command to create a Jenkins pipeline
   ```
   ./050-cicd.sh
   ```
2. To see the Jenkins pipeline and to approve the move to test --> production, launch the OpenShift web console under the created OpenShift cluster.
3. Select `cicd` project from the dropdown and Navigate to Build --> Pipelines. Click on `Input Required` to see the pipeline.

## CleanUp

1. Run `./delete.sh` to delete the resources and the projects.
2. Run `./delete.sh development` to delete the individual resources.
