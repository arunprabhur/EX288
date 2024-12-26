#!/bin/bash

source ../common.sh

echo -e  "\n Starting script --> Creating a Simple deployment and debug the failure, fix and redeploy it in Openshift Cluster"

prompt

execute "login to OCP4" '''oc login -u developer -p developer https://api.ocp4.example.com:6443'''
execute "Create New Project" '''oc new-project mylab1'''
execute "Creating New app for the bash app from git" '''oc new-app --strategy docker --name mybashapp --context-dir /lab7 https://github.com/arunprabhur/EX288.git'''
execute "Check whether new build is created and running" '''oc get po'''
execute "Deleting Project" '''oc delete project mylab1'''
endofscript

echo "End of script"
