#!/bin/bash

source ../common.sh

echo -e  "\n Starting script --> Creating an app using docker file and run it in Openshift Cluster"

prompt

execute "Creating an image for bash script" '''podman build -t registry.ocp4.example.com:8443/developer/mybashapp:1.0 .'''
execute "Pushing image into temp registry" '''podman push registry.ocp4.example.com:8443/developer/mybashapp:1.0''' 
execute "login to OCP4" '''oc login -u developer -p developer https://api.ocp4.example.com:6443'''
execute "Create New Project" '''oc new-project mylab1'''
execute "Creating New app for the bash app" '''oc new-app --image registry.ocp4.example.com:8443/developer/mybashapp:1.0 --name mybashapp'''
execute "check pods running status" '''oc get po'''
clear
execute "View all resources created" ''' oc get all'''
execute "Scale up to 5 pods" '''oc scale --replicas 5 deployment/mybashapp'''
execute "view scaled up pods" '''oc get po'''
execute "Deleting Project" '''oc delete project mylab1'''
endofscript

echo "End of script"
