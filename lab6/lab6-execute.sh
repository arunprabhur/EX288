#!/bin/bash

source ../common.sh

echo -e  "\n Starting script --> Creating an app using docker file from git and run it in Openshift Cluster"

prompt

execute "login to OCP4" '''oc login -u developer -p developer https://api.ocp4.example.com:6443'''
execute "Create New Project" '''oc new-project mylab1'''
execute "Create a ubi-redhat-image stream" '''oc import-image ubi-redhat-is --from registry.access.redhat.com/ubi8-minimal:8.10-1154 --confirm'''
echo -e "To run a local folder \n 1. oc new-app --name mybashapp --strategy docker \n"
echo -e "2. oc start-build buildconfig/mybashapp --from-dir ."
read -p "Enter to continue"
execute "Creating New app for the bash app from git" '''oc new-app --strategy docker --name mybashapp --context-dir /lab2 https://github.com/arunprabhur/EX288.git'''
sleep 15
execute "check pods running status" '''oc get po'''
sleep 15
clear
execute "View all resources created" ''' oc get all'''
execute "Scale up to 5 pods" '''oc scale --replicas 5 deployment/mybashapp'''
execute "view scaled up pods" '''oc get po'''
execute "Deleting Project" '''oc delete project mylab1'''
endofscript

echo "End of script"
