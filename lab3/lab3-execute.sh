#!/bin/bash

source ../common.sh

echo -e  "\n Starting script --> Creating an app using docker file from git and run it in Openshift Cluster"

prompt

execute "login to OCP4" '''oc login -u developer -p developer https://api.ocp4.example.com:6443'''
execute "Create New Project" '''oc new-project mylab1'''
clear
execute "Create a generic secret via literal" '''oc create secret generic example-secret --from-literal=user=developer'''
execute "check secrets" '''oc get secret'''
execute "describe generic secret" '''oc get secret example-secret -o yaml'''
execute "create docker registry secret" '''oc create secret docker-registry quay-secret --docker-server registry.ocp4.example.com:8443 --docker-username developer --docker-password developer --docker-email prabhu.arun10@gmail.com'''
execute "describe docker secrets quay-secret" '''oc get secret quay-secret -o yaml'''
execute "Importing Images from external registry to image stream" '''oc import-image ubi8/openjdk-21:1.21-1.1733300817 --from=registry.access.redhat.com/ubi8/openjdk-21:1.21-1.1733300817 --confirm'''
execute "Check Image stream in project" '''oc get is'''
execute "Check Image stream and its tag" '''oc get istag'''
execute "Describe tags of the image stream" '''oc describe is openjdk'''
execute "Deleting Project" '''oc delete project mylab1'''
endofscript

echo "End of script"
