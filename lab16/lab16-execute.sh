#!/bin/bash

source ../common.sh

echo -e  "\n Starting script --> create app  using helm and understanding Go templates using a test configmap in Openshift Cluster"

prompt

execute "login to OCP4" '''oc login -u developer -p developer https://api.ocp4.example.com:6443'''
execute "Create New Project" '''oc new-project mylab1'''
execute "Viewing base project" '''oc kustomize mystatefulapp/base'''
execute "Apply the base project" '''oc apply -k mystatefulapp/base'''
execute " view the test config map" '''oc get cm test-configmap -o yaml'''
execute "Delete the config map" '''oc delete cm test-configmap'''
execute "Apply environment dev" '''oc apply -k mystatefulapp/environment/dev'''
execute " view the test config map" '''oc get cm test-configmap -o yaml'''
execute "Delete the config map" '''oc delete cm test-configmap'''
execute "Apply environment prod" '''oc apply -k mystatefulapp/environment/prod'''

execute " view the test config map" '''oc get cm test-configmap -o yaml'''
execute "Deleting the project" '''oc delete project mylab1'''
endofscript

echo "End of script"
