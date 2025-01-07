#!/bin/bash

source ../common.sh

echo -e  "\n Starting script --> create pvc and apply into bash app, create app with statefulset with different pvc in Openshift Cluster"

prompt

execute "login to OCP4" '''oc login -u developer -p developer https://api.ocp4.example.com:6443'''
execute "Create New Project" '''oc new-project mylab1'''
execute "Creating New app for the bash app from git using helm chart" '''helm install --set replicaCount=5  myapp  mystatefulapp'''
execute "watch  pods" '''watch oc get po'''
execute "view the values.yaml file" '''cat mystatefulapp/values.yaml'''
execute "View the test config map file" '''cat mystatefulapp/templates/test-configmap.yaml'''
execute "Render the Go template and view the result" ''' helm template mystatefulapp'''
execute "Uninstall app using helm" '''helm uninstall myapp'''
execute "Deleting the project" '''oc delete project mylab1'''
endofscript

echo "End of script"
