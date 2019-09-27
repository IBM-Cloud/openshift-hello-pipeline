#!/bin/bash
if [[ -z "$1" ]]; then
    environments=('development' 'testing' 'production' 'cicd')
    for env in "${environments[@]}"; do
        echo "DELETING RESOURCES in ${env}..."
        oc delete all -l app=hello-node-app -n $env
        oc delete project $env
    done
    elif [[ -n "$1" ]]; then
    echo "DELETING RESOURCES in $1..."
    oc delete all -l app=hello-node-app -n $1
    oc delete project $1
fi